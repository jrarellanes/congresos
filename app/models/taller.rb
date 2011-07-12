class Taller < ActiveRecord::Base
  validates :nombre, :presence => true
  validates :precio, :presence => true
  validates :max_participantes, :presence => true

  belongs_to :congreso
end
