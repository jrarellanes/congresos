class AlterFacturas < ActiveRecord::Migration
  def change
    remove_column :facturas, :direccion
    add_column :facturas, :calle, :string
    add_column :facturas, :numero, :integer
  end
end
