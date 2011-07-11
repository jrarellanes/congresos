class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string        :nombre, :limit => 100
      t.string        :apellido_paterno, :limit => 100
      t.string        :apellido_materno, :limit => 100

      t.timestamps
    end
  end
end
