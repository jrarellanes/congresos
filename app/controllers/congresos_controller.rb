#encoding: utf-8
class CongresosController < ApplicationController
  include XlsxHelper
  before_filter :authenticate, :except => [:registro, :registrar, :confirmar_pago, :agradecimiento, :busqueda, :buscar, :paso_pago]
  before_filter :verificar_origen, :only => :confirmar_pago
  before_filter :fecha_limite_registro, :only => :registro
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
    @persona.congreso = @congreso
    estatus = true
    unless params[:persona][:taller_ids] == nil
      if @congreso.id == 3 && params[:persona][:taller_ids].size > 1
        estatus = false
        @persona.errors.add("talleres", "No puede seleccionar mas de un taller")
      end
    end

    if estatus && @persona.save
      precio = @congreso.precio
      @persona.update_attribute("pago", true) unless @congreso.pago
      @persona.talleres.each do |taller|
        precio += taller.precio
      end

      if params[:factura] == "true"
        redirect_to new_facturas_url(@persona), :notice => "Por favor introduzca los datos de facturación"
      else
        #redirect_to pagos_url(@persona,"#{precio.to_s}0","n208")
        #Confirmamos el pago siempre...

        #redirect_to @persona, :notice => "Participante registrado exitosamente"
        #if @congreso.pago
          #redirect_to congreso_confirmar_pago_path(@congreso.id,@persona.id,'00000',"PAGOS"), :notice => "Participante registrado exitosamente"
        #else
        if precio> 0
          redirect_to paso_pago_url @persona.talleres.count
        else
          redirect_to agradecimiento_registro_url @persona
        end
        
        #end
      end
    else
      @estados = Estado.all
      flash[:notice] = "No es posible seleccionar más de un taller" unless estatus
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
      if params.include? campo.nombre
        CamposCongreso.create(:congreso_id => congreso_id, :campo_id => campo.id)
      end
    end
  end

  def eliminar_campos_anteriores(congreso_id)
    puts congreso_id

    campos = CamposCongreso.where("congreso_id = ?", 19)
    campos.each do |campo|
      
    end
  end
end
