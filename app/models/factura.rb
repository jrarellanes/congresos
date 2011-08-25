class Factura < ActiveRecord::Base
  belongs_to :pais
  belongs_to :estado
  belongs_to :persona
end
