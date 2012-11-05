class CreateRegistroCl2s < ActiveRecord::Migration
  def change
    create_table :registro_cl2s do |t|
      t.integer :persona_id

      t.timestamps
    end
  end
end
