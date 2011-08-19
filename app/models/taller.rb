class Taller < ActiveRecord::Base
  validates :nombre, :presence => true
  validates :precio, :presence => true
  validates :max_participantes, :presence => true
  validate :precio_mayor_cero

  belongs_to :congreso

  has_and_belongs_to_many :personas, :order => "apellido_paterno"

  def to_s
    nombre
  end

  def precio_mayor_cero
   if self.precio < 0
     errors.add(:precio_negativo, "El precio no puede ser menor que cero")
   end
 end
end
