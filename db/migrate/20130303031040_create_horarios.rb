class CreateHorarios < ActiveRecord::Migration
  def change
    create_table :horarios do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :cupo
      t.integer :congreso_id

      t.timestamps
    end
  end
end
