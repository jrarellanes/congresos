class FacturasController < ApplicationController
  def index
  end

  def new
    @factura = Factura.new
    @estados = Estado.all
    @ciudades = Ciudad.all
    @persona = Persona.find(params[:id])
  end

  def edit
  end

  def show
    @factura = Factura.find(params[:id])
  end

  def create
    @factura = Factura.new(params[:factura])
    if @factura.save
      flash[:notice] = "Datos factura guardada correctamente"
      redirect_to @factura
    else
      @estados = Estado.all
      @paises = Pais.all
      render 'new'
    end
  end
end
