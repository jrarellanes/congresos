class Horario < ActiveRecord::Base
  belongs_to :congreso
  has_and_belongs_to_many :personas
end
