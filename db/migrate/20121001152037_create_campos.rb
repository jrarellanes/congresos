class CreateCampos < ActiveRecord::Migration
  def change
    create_table :campos do |t|
      t.string :nombre

      t.timestamps
    end
  end
end
