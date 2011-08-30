class CreateTalleres < ActiveRecord::Migration
  def change
    create_table :talleres do |t|
      t.string  :nombre, :limit => 300
      t.text    :descripcion
      t.decimal :precio, :scale => 2, :precision => 12
      t.integer :max_participantes
      t.timestamps
    end
  end
end
