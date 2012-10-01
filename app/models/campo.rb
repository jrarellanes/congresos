class Campo < ActiveRecord::Base
  validates :nombre, :presence => true
  has_and_belongs_to_many :congresos
end
