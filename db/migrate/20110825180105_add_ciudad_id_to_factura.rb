class AddCiudadIdToFactura < ActiveRecord::Migration
  def change
    add_column :facturas, :ciudad_id, :integer
  end
end
