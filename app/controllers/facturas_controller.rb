class FacturasController < ApplicationController
  def index
  end

  def new
    @factura = Factura.new
    @estados = Estado.all
    @persona = Persona.find(params[:id])
  end

  def edit
  end

  def show
    @factura = Factura.find(params[:id])
  end

  def create
    @factura = Factura.new(params[:factura])
    @persona = @factura.persona

    if @factura.save
      precio = @persona.congreso.precio
      @persona.talleres.each do |taller|
        precio += taller.precio
      end

      #if @persona.congreso.pago
        #redirect_to congreso_confirmar_pago_path(@congreso.id,@persona.id,'00000',"PAGOS"), :notice => "Participante registrado exitosamente"
        #redirect_to pagos_url(@persona,"#{precio.to_s}0","n68")
      #else
        redirect_to paso_pago_url @persona.talleres.count
      #end
    else
      @estados = Estado.all
      @paises = Pais.all
      render 'new'
    end
  end
end
