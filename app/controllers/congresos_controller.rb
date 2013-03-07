#encoding: utf-8
class CongresosController < ApplicationController
  include XlsxHelper
  before_filter :authenticate, :except => [:registro, :registrar, :confirmar_pago, :agradecimiento, :busqueda, :buscar, :paso_pago]
  before_filter :verificar_origen, :only => :confirmar_pago
  before_filter :fecha_limite_registro, :only => :registro
  before_filter :validar_cupo, :only => [:registro, :registrar]
# before_filter {|edit|  edit.congreso_propio?(Congreso.find(params[:id]))}
  # GET /congresos
  # GET /congresos.json
  def index
    @congresos = Congreso.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @congresos }
    end
  end

  # GET /congresos/1
  # GET /congresos/1.json
  def show
    @congreso = Congreso.find(params[:id])
    @datos_lucrativos = false
    @datos_lucrativos = true if @congreso.talleres.where("precio > 0").count > 0 || @congreso.precio > 0
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @congreso }
    end
  end

  # GET /congresos/new
  # GET /congresos/new.json
  def new
    @congreso = Congreso.new
    @campos = Campo.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @congreso }
    end
  end

  # GET /congresos/1/edit
  def edit
    @congreso = Congreso.find(params[:id])
    @campos = Campo.all
  end

  # POST /congresos
  # POST /congresos.json
  def create
    @congreso = Congreso.new(params[:congreso])
    @congreso.user_id = current_user.id
    
    respond_to do |format|
      if @congreso.save
        crear_campos_congreso(params, @congreso.id)
        CongresosUser.create(:user_id => current_user.id, :congreso_id => @congreso.id)
        format.html { redirect_to @congreso, notice: 'Congreso registrado correctamente.' }
        format.json { render json: @congreso, status: :created, location: @congreso }
      else
        @campos = Campo.all
        format.html { render action: "new" }
        format.json { render json: @congreso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /congresos/1
  # PUT /congresos/1.json
  def update
    @congreso = Congreso.find(params[:id])
    @datos_lucrativos = false
    @datos_lucrativos = true if @congreso.talleres.where("precio > 0").count > 0 || @congreso.precio > 0

    if params[:congreso][:pago] == "1" or @datos_lucrativos
      @congreso.personas_confirmadas.each do |persona|
        persona.update_attribute("pago", false)
      end
    else
      @congreso.personas_sin_confirmar.each do |persona|
        persona.update_attribute("pago", true) 
      end
    end

    respond_to do |format|
      if @congreso.update_attributes(params[:congreso])
        format.html do 
          eliminar_campos_anteriores(params[:id])
          crear_campos_congreso(params, params[:id])
          redirect_to @congreso, notice: 'Congreso actualizado correctamente.'
        end
        format.json { head :ok }
      else
        @campos = Campo.all
        format.html { render action: "edit" }
        format.json { render json: @congreso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /congresos/1
  # DELETE /congresos/1.json
  def destroy
    @congreso = Congreso.find(params[:id])
    if congreso_propio?(@congreso) or current_user.is_admin?
      @congreso.destroy
      respond_to do |format|
          format.html { redirect_to congresos_url }
          format.json { head :ok }
    end
    else
      flash[:notice] = "Solo puedes eliminar tus propios congresos"
      redirect_to congresos_url
    end

    
  end

  def registro
    @persona = Persona.new
    @congreso = Congreso.find(params[:id])
    @estados = Estado.all
    @datos_lucrativos = false
    @datos_lucrativos = true if @congreso.talleres.where("precio > 0").count > 0 || @congreso.precio > 0
  end    

  def paso_pago
    @no_items = params[:no_items]
  end

  def registrar
    @congreso = Congreso.find(params[:id])
    @persona = Persona.new(params[:persona])
    if @congreso.pago && params[:persona].include?(:comprobante_pago)
      @persona.congreso = @congreso
      #esta variable se tiene que cambiar por estatus_talleres
      estatus = true
      estatus_horarios = true
      estatus_sin_horario = true

      if @congreso.requiere_horario
        unless params[:persona][:horario_ids] == nil
          if @congreso.id == 34 && params[:persona][:horario_ids].size > 1
            estatus_horarios = false
            @persona.errors[:base] << "Solo puede seleccionar un horario."
          end
        else
          estatus_sin_horario = false
          @persona.errors[:base] << "Debe seleccionar un horario."
        end
      end


      unless params[:persona][:taller_ids] == nil
        if @congreso.id == 34 && params[:persona][:taller_ids].size > 1
          estatus = false
          @persona.errors[:base] << "No puede seleccionar más de un taller"
        end
      end

      if estatus && estatus_horarios && estatus_sin_horario && @persona.save
        precio = @congreso.precio
        @persona.update_attribute("pago", true) unless @congreso.pago
        if params[:persona].include?(:taller_ids)
          params[:persona][:taller_ids].each do |taller_id|
            taller = Taller.find taller_id
            precio += taller.precio
          end
        end
        #Son los 3 tracks de campus link 2.0
=begin
        if @congreso.id == 14 || @congreso.id == 15 || @congreso.id == 16
          RegistroCl2.create(:persona_id => @persona.id)
        end
=end
        if params[:factura] == "true"
          redirect_to new_facturas_url(@persona), :notice => "Por favor introduzca los datos de facturación"
        else
          #redirect_to pagos_url(@persona,"#{precio.to_s}0","n208")
          #Confirmamos el pago siempre...

          #redirect_to @persona, :notice => "Participante registrado exitosamente"
          #if @congreso.pago
            #redirect_to congreso_confirmar_pago_path(@congreso.id,@persona.id,'00000',"PAGOS"), :notice => "Participante registrado exitosamente"
          #else
          #
          #if precio> 0 && @congreso.id != 34
           # redirect_to paso_pago_url @persona.talleres.count
          #else
            redirect_to agradecimiento_registro_url @persona
          #end

          #end
        end
      else
        @estados = Estado.all
        @datos_lucrativos = false
        @datos_lucrativos = true if @congreso.talleres.where("precio > 0").count > 0 || @congreso.precio > 0
        flash[:notice] = " "
        flash[:notice] += "No es posible seleccionar más de un taller. " unless estatus
        flash[:notice] += "No es posible agregar más de un horario." unless estatus_horarios
        flash[:notice] = "Debe seleccionar un horario." unless estatus_sin_horario
        render :action => "registro"
      end
    else
      @estados = Estado.all
      @datos_lucrativos = false
      @datos_lucrativos = true if @congreso.talleres.where("precio > 0").count > 0 || @congreso.precio > 0
      @persona.errors[:base] << "Debe adjuntar comprobante de pago."
      flash[:notice] = "Debe adjuntar comprobante de pago."
       render :action => "registro"
    end
  end

  def agradecimiento
    @participante = Persona.find params[:usuario_id]

    
  end
  
  def buscar_constancia
    @congreso = Congreso.find(params[:id])    
  end
  
  def constancias
    @congreso = Congreso.find(params[:id])
    email = params[:correo]    
    @personas = @congreso.personas_confirmadas.where(:email => email)
  end
  
  def constancia
    @congreso = Congreso.find(params[:id])
    @persona = @congreso.personas_confirmadas.where(:id => params[:persona_id]).first
    
    respond_to do |format|
      format.html do 
        render  "constancia", :layout => "constancias"
      end
      format.pdf do 
        render  :pdf => "Constancia #{@congreso.nombre}",
                :template => "congresos/constancia",
                :layout =>  "constancias.html"              
      end
    end
  end

  def talleres
    @congreso = Congreso.find(params[:id])
  end


  def participantes
    @congreso = Congreso.find(params[:id])

    respond_to do |format|
      format.xlsx do
        data  = create_xlsx_participantes(@congreso)
        send_data data, :filename => 'participantes.xlsx', :type => :xlsx
      end
    end
  end

  def confirmar_pago
    @congreso = Congreso.find(params[:id])
    @persona = Persona.find(params[:id_cliente])
    @persona.informacion_pago = params[:id_transaccion]
    @persona.pago = true
    @persona.save

    flash[:notice] = "Participante registrado exitosamente"
    redirect_to root_path
  end

  def busqueda
    #@congresos = Congreso.order "id"
    @id = params[:id]
  end

  def buscar
    @id = params[:id]
    to_render = "resultado_busqueda.html"
    if params[:numero_registro] == 'true'
      begin
          @personas = Persona.where("id = ? AND congreso_id = ?", params[:numero].to_i, params[:id])
      rescue  => e
        to_render = "elemento_no_encontrado.html"
      end
    else
      @personas = []
      personas_congreso = Persona.find_all_by_congreso_id params[:id]
      personas_congreso.each do |persona|
        unless @personas.include?(persona)
          if persona.nombre.upcase == params[:nombre].upcase
            @personas << persona
          end
        end
        unless @personas.include?(persona)
          if persona.apellido_paterno.upcase == params[:apellido_paterno].upcase
            @personas << persona
          end
        end
        unless @personas.include?(persona)
          if persona.apellido_materno.upcase == params[:apellido_materno].upcase
            @personas << persona
          end
        end
      end
    end
    render "#{to_render}"
  end

  private
  def verificar_origen
    unless params[:origen] == "PAGOS"
      @congreso = Congreso.find(params[:id])
      flash[:notice] = "No se realizó la confirmación de pago"
      redirect_to congreso_registro_path(@congreso.id)
    end
  end

  def fecha_limite_registro
    @congreso = Congreso.find params[:id]
    if @congreso.limite_registro != nil
      if @congreso.limite_registro < Time.now.to_date
        flash[:error] = "Este congreso ha terminado"
        redirect_to  root_path
      end
    else
      if @congreso.fecha_fin < Time.now.to_date
        flash[:error] = "Este congreso ha terminado"
        redirect_to  root_path
      end
    end
  end

  def is_numeric?
    true if Float(self) rescue false
  end

  def crear_campos_congreso(params, congreso_id)
    Campo.all.each do |campo|
      if params.include? campo.id.to_s
        CamposCongreso.create(:congreso_id => congreso_id, :campo_id => campo.id)
      end
    end
  end

  def eliminar_campos_anteriores(congreso_id)
    sql = ActiveRecord::Base.connection();
    sql.execute "delete from campos_congresos where congreso_id = #{congreso_id};";
  end

  def validar_cupo
    congreso = Congreso.find params[:id]
    unless congreso.cupo.nil?
      if Persona.where(:congreso_id => congreso.id).count >= congreso.cupo
        flash[:notice] = "Cupo lleno"
        redirect_to root_path
      end
    end
  end
end
