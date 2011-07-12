class AddPrecioToCongreso < ActiveRecord::Migration
  def change
    add_column :congresos, :precio, :decimal, :scale => 2, :precision => 12
  end
end
