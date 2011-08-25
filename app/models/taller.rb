class Taller < ActiveRecord::Base
  validates :nombre, :presence => true
  validates :precio, :presence => true
  validates :max_participantes, :presence => true
  validate :precio_mayor_cero
  validate :fecha_inicio_mayor_fecha_fin
  validate :max_participantes_may_uno

  belongs_to :congreso

  has_and_belongs_to_many :personas, :order => "apellido_paterno"

  def to_s
    nombre
  end


  def precio_mayor_cero
   if precio != nil
     if precio < 0
        errors.add(:precio_negativo, "El precio no puede ser menor que cero")
     end
   end
 end

  def fecha_inicio_mayor_fecha_fin
    if self.fecha_fin < self.fecha_inicio
      errors.add(:fecha_fin_menor, "La fecha final del curso debe ser mayor que la de inicio")
    end
  end

  def max_participantes_may_uno
    if max_participantes != nil
        if self.max_participantes < 1
         errors.add(:max_participantes_negativo, "El maximo de participantes no puede ser menor que uno")
        end
    end
  end
end
