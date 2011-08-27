class ChangeEstadoInFacturas < ActiveRecord::Migration
  def up
    remove_column :facturas, :estado
    add_column :facturas, :estado_id, :integer
  end

  def down
    remove_column :facturas, :estado_id
    add_column :facturas, :estado, :string
  end
end
