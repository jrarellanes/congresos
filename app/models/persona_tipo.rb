class PersonaTipo < ActiveRecord::Base
  belongs_to :congreso

  validates :nombre, :presence => true
  validates :siglas, :presence => true
end
