class Taller < ActiveRecord::Base
  validates :nombre, :presence => true
  validates :precio, :presence => true
  validates :max_participantes, :presence => true

  belongs_to :congreso

  has_and_belongs_to_many :personas, :order => "apellido_paterno"
end
