#encoding: utf-8
class CongresosController < ApplicationController
  include XlsxHelper
  before_filter :authenticate, :except => [:registro, :registrar, :confirmar_pago]
  before_filter :verificar_origen, :only => :confirmar_pago
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

    if @persona.save
      if params[:descuento] == "1"
        precio = @congreso.precio_descuento
      else
        precio = @congreso.precio
      end

      @persona.talleres.each do |taller|
        precio += taller.precio
      end

      if params[:factura] == "1"
        redirect_to new_facturas_url(@persona), :notice => "Por favor introduzca los datos de facturación"
      else
        redirect_to pagos_url(@persona,"#{precio.to_s}0","n68")
        #redirect_to @persona, :notice => "Participante registrado exitosamente"
      end
    else
      @estados = Estado.all
      render :action => "registro"
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

    flash[:notice] = "Su pago ha sido confirmado correctamente"
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
end
