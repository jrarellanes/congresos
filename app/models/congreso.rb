class Congreso < ActiveRecord::Base
  validates :nombre, :presence => true
  validate :precio_mayor_cero

  has_many :talleres, :class_name => "Taller", :order => "nombre"
  has_many :personas, :order => "apellido_paterno"

 def precio_mayor_cero
   if self.precio < 0
     errors.add(:precio_negativo, "El precio no puede ser menor que cero")
   end
 end
end
