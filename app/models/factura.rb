class Factura < ActiveRecord::Base

  validates :nombre, :presence => true
  validates :calle, :presence => true
  validates :numero, :presence => true
  validates :rfc, :presence => true
  validates :cp, :presence => true
  validates :ciudad, :presence => true

  belongs_to :pais
  belongs_to :estado
  belongs_to :persona
end
