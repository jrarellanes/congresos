class Persona < ActiveRecord::Base
  validates :nombre, :presence => true
  validates :apellido_paterno, :presence => true
  validates :apellido_materno, :presence => true

  has_and_belongs_to_many :talleres, :class_name => "Taller", :order => "nombre"
  belongs_to :congreso

  def nombre_completo
    "#{nombre} #{apellido_paterno} #{apellido_materno}"
  end
end
