class PersonaTipo < ActiveRecord::Base
  belongs_to :congreso

  validates :nombre, :presence => true
end
