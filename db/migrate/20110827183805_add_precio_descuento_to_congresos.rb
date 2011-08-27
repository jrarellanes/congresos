class AddPrecioDescuentoToCongresos < ActiveRecord::Migration
  def change
    add_column :congresos, :precio_descuento, :decimal, :scale => 2, :precision => 12
  end
end
