class Congreso < ActiveRecord::Base
  validates :nombre, :presence => true
  validates :precio, :presence => true
  validate :precio_mayor_cero
  validate :fecha_inicio_mayor_fecha_fin

  belongs_to :user
  has_many :talleres, :class_name => "Taller", :order => "nombre", :dependent => :delete_all
  has_many :personas, :order => "apellido_paterno", :dependent => :delete_all
  has_many :persona_tipos, :order => "nombre", :dependent => :delete_all

  def precio_mayor_cero
   if precio != nil
     if precio < 0
        errors.add(:precio_negativo, "El precio no puede ser menor que cero")
     end
   end
  end

  def personas_confirmadas
    personas.where(:pago => true)
  end

  def personas_sin_confirmar
    personas.where(:pago => false)
  end

  def fecha_inicio_mayor_fecha_fin
    if fecha_fin < fecha_inicio
      errors.add(:fecha_fin_menor, "La fecha final del curso debe ser mayor que la de inicio")
    end
  end

  def talleres_con_cupo
    talleres_cupo = []
    talleres.each do |taller|
      if taller.cupo?
        talleres_cupo << taller
      end
    end
    talleres_cupo
  end
end
