module CongresosHelper
  def persona_inscrita_en_taller?(taller)
    if @persona && !@persona.nombre.nil?
          @persona.talleres.include?(taller)
        else
          false
        end

  end
end
