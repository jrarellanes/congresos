class CreateCiudads < ActiveRecord::Migration
  def change
    create_table :ciudades do |t|
      t.string :nombre
      t.string :siglas
      t.integer :factura_id

      t.timestamps
    end
  end
end
