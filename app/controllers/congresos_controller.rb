#encoding: utf-8
class CongresosController < ApplicationController
  include XlsxHelper
  before_filter :authenticate, :except => [:registro, :registrar, :confirmar_pago, :agradecimiento]
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

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @congreso }
    end
  end

  # GET /congresos/new
  # GET /congresos/new.json
  def new
    @congreso = Congreso.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @congreso }
    end
  end

  # GET /congresos/1/edit
  def edit
    @congreso = Congreso.find(params[:id])
  end

  # POST /congresos
  # POST /congresos.json
  def create
    @congreso = Congreso.new(params[:congreso])
    @congreso.user_id = current_user.id

    respond_to do |format|
      if @congreso.save
        format.html { redirect_to @congreso, notice: 'Congreso registrado correctamente.' }
        format.json { render json: @congreso, status: :created, location: @congreso }
      else
        format.html { render action: "new" }
        format.json { render json: @congreso.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /congresos/1
  # PUT /congresos/1.json
  def update
    @congreso = Congreso.find(params[:id])

    respond_to do |format|
      if @congreso.update_attributes(params[:congreso])
        format.html { redirect_to @congreso, notice: 'Congreso actualizado correctamente.' }
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
  end    

  def registrar
    @congreso = Congreso.find(params[:id])
    @persona = Persona.new(params[:persona])
    @persona.congreso = @congreso
    estatus = true
    unless params[:persona][:taller_ids] == nil
      if params[:persona][:taller_ids].size > 1 and @congreso.id == 3
        estatus = false
        @persona.errors.add("talleres", "No puede seleccionar mas de un taller")
      end
    end

    if @persona.save and estatus
      if @persona.persona_tipo.nombre == "Estudiante"
        precio = @congreso.precio_descuento
      else
        precio = @congreso.precio
      end

      @persona.talleres.each do |taller|
        precio += taller.precio
      end

      if params[:factura] == "true"
        redirect_to new_facturas_url(@persona), :notice => "Por favor introduzca los datos de facturación"
      else
        #redirect_to pagos_url(@persona,"#{precio.to_s}0","n208")
        #Confirmamos el pago siempre...

        #redirect_to @persona, :notice => "Participante registrado exitosamente"
        if @congreso.pago
          redirect_to congreso_confirmar_pago_path(@congreso.id,@persona.id,'00000',"PAGOS"), :notice => "Participante registrado exitosamente"
        else
          redirect_to agradecimiento_registro_url @persona
        end
      end
    else
      @estados = Estado.all
      flash[:notice] = "No puede seleccionar mas de un congreso" unless estatus
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
    redirect_to participante_url(@persona.id)
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
    if @congreso.fecha_fin < Time.now.to_date
      flash[:error] = "Este congreso ha terminado"
      redirect_to  root_path
    end
  end
end
