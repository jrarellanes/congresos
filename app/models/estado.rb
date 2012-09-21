class Estado < ActiveRecord::Base
  belongs_to :pais
  has_one :factura
  has_many :personas
end
