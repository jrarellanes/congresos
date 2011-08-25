class Estado < ActiveRecord::Base
  has_one :factura
  has_many :personas
end
