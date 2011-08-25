class PersonasController < ApplicationController
  def edit
    @participante = Persona.find(params[:id])
  end

  def update
    @participante = Persona.find(params[:id])

    if @participante.update_attributes(params[:persona])
      redirect_to participante_url(@participante), notice: "Participante editado correctamente"
    else
      render 'edit'
    end
  end

  def show
    @participante = Persona.find(params[:id])
  end

  def index
    @participantes = Persona.all
  end
end