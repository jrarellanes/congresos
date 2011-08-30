class PersonaTipo < ActiveRecord::Base

  belongs_to :congreso
  has_many :personas, :order => "apellido_paterno"

  validates :nombre, :presence => true

  def to_s
    nombre
  end
end
