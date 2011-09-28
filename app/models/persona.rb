class Persona < ActiveRecord::Base
  validates :nombre, :presence => true
  validates :apellido_paterno, :presence => true
  validates :apellido_materno, :presence => true
  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }
  #validates :calle, :presence => true
  #validates :numero, :presence => true
  #validates :cp, :presence => true
  validates :institucion, :presence => true
  validates :ciudad, :presence => true

  has_and_belongs_to_many :talleres, :class_name => "Taller", :order => "nombre"
  belongs_to :congreso
  belongs_to :estado
  has_one :factura
  belongs_to :persona_tipo

  def nombre_completo
    "#{nombre} #{apellido_paterno} #{apellido_materno}"
  end
end
