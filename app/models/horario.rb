class Horario < ActiveRecord::Base
  validates :cupo, :nombre, :presence => true
  belongs_to :congreso
  has_and_belongs_to_many :personas

  def cupo?
    if self.personas.count >= cupo
      false
    else
      true
    end
  end
end
