module CongresosHelper
  def persona_inscrita_en_taller?(taller)
    if @persona && !@persona.nombre.nil?
          @persona.talleres.include?(taller)
        else
          false
        end

  end

  def definir_precio(persona)
    unless persona.persona_tipo.precio == nil
      precio = persona.persona_tipo.precio
    else
      precio = persona.congreso.precio
    end
    precio
  end
end
