class Congreso < ActiveRecord::Base
  validates :nombre, :presence => true
end
