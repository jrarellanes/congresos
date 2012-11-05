#encoding: utf-8
class Persona < ActiveRecord::Base
  validates :nombre, :presence => true, :if => Proc.new {|person| person.congreso.campos.include? Campo.find_by_nombre "Nombre"}
  validates :apellido_paterno, :presence => true, :if => Proc.new {|person| person.congreso.campos.include? Campo.find_by_nombre "Apellido Paterno"}
  validates :apellido_materno, :presence => true, :if => Proc.new {|person| person.congreso.campos.include? Campo.find_by_nombre "Apellido Materno"}
  validates :email,
            :presence => true,
            :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }, :if => Proc.new {|person| person.congreso.campos.include? Campo.find_by_nombre "Email"}
  #validates :calle, :presence => true
  #validates :numero, :presence => true
  #validates :cp, :presence => true
  validates_uniqueness_of :email, :scope => [:congreso_id], :if => Proc.new {|person| person.congreso.campos.include? Campo.find_by_nombre "Email"}

  validates :institucion, :presence => true, :if => Proc.new {|person| person.congreso.campos.include? Campo.find_by_nombre "Institución"}
  validates :ciudad, :presence => true, :if => Proc.new {|person| person.congreso.campos.include? Campo.find_by_nombre "Ciudad"}

  has_and_belongs_to_many :talleres, :class_name => "Taller", :order => "nombre"
  belongs_to :congreso
  belongs_to :estado
  has_one :factura
  has_one :registro_cl2
  belongs_to :persona_tipo
  belongs_to :grado_estudio
  belongs_to :pais

   has_attached_file :comprobante_pago, :styles => { :medium => "300x300>"}

  def nombre_completo
    "#{nombre unless nombre.nil?} #{apellido_paterno unless apellido_paterno.nil?} #{apellido_materno unless apellido_materno.nil?}"
  end

end
