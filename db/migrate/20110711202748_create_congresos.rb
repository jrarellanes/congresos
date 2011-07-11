class CreateCongresos < ActiveRecord::Migration
  def change
    create_table :congresos do |t|
      t.string :nombre
      t.text :descripcion

      t.timestamps
    end
  end
end
