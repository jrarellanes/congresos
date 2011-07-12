class Persona < ActiveRecord::Base
  validates :nombre, :presence => true
  validates :apellido_paterno, :presence => true
  validates :apellido_materno, :presence => true
  validates :email,
            :presence => true,
            :uniqueness => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  has_and_belongs_to_many :talleres, :class_name => "Taller", :order => "nombre"
  belongs_to :congreso

  def nombre_completo
    "#{nombre} #{apellido_paterno} #{apellido_materno}"
  end
end
