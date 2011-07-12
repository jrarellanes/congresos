class Congreso < ActiveRecord::Base
  validates :nombre, :presence => true

  has_many :talleres, :class_name => "Taller", :order => "nombre"
  has_many :personas, :order => "apellido_paterno"
end
