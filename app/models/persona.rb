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
  has_and_belongs_to_many :horarios, :class_name => "Horario", :order => "nombre"
  belongs_to :congreso
  belongs_to :estado
  has_one :factura
  has_one :registro_cl2
  belongs_to :persona_tipo
  belongs_to :grado_estudio
  belongs_to :pais

  before_destroy :eliminar_rcl2

   has_attached_file :comprobante_pago, :styles => { :medium => "300x300"}

  #validate :validar_nombre_completo

  def eliminar_rcl2
    p = RegistroCl2.find_by_persona_id self.id
    p.destroy if p.respond_to? "destroy"
  end

  def validar_nombre_completo
    if self.congreso.campos.include? (Campo.find_by_nombre "Apellido Paterno") and self.congreso.campos.include? (Campo.find_by_nombre "Apellido Materno") and self.congreso.campos.include? (Campo.find_by_nombre "Nombre") and self.congreso.campos.include? (Campo.find_by_nombre "Email")
    persona = Persona.where("upper(nombre) = ? AND upper(apellido_paterno) = ? AND upper(apellido_materno) = ? AND (congreso_id = 14 OR congreso_id = 15 OR congreso_id = 16)", self.nombre.upcase, self.apellido_paterno.upcase, self.apellido_materno.upcase)
    persona2 = Persona.where("upper(email) = ? AND (congreso_id = 16 OR congreso_id = 15 OR congreso_id = 14)", self.email.upcase)

    if persona.size > 0 or persona2.size > 0
      self.errors[:base] << "Este usuario ya ha sido registrado"
    end

    end

  end

  def nombre_completo
    "#{nombre unless nombre.nil?} #{apellido_paterno unless apellido_paterno.nil?} #{apellido_materno unless apellido_materno.nil?}"
  end

end
