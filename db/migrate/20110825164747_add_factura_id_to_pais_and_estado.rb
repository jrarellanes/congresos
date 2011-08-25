class AddFacturaIdToPaisAndEstado < ActiveRecord::Migration
  def change
    add_column :paises, :factura_id, :integer
    add_column :estados, :factura_id, :integer
  end
end
