class CreateFacturas < ActiveRecord::Migration
  def change
    create_table :facturas do |t|
      t.string :nombre
      t.string :direccion
      t.integer :cp
      t.string :rfc
      t.string :ciudad
      t.string :estado
      t.string :pais

      t.timestamps
    end
  end
end
