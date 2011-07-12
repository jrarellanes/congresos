class Congreso < ActiveRecord::Base
  validates :nombre, :presence => true

  has_many :talleres, :class_name => "Taller"
end
