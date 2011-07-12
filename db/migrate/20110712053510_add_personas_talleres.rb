class AddPersonasTalleres < ActiveRecord::Migration
  def change
    create_table :personas_talleres, :id => false do |t|
      t.integer :persona_id
      t.integer :taller_id
    end
  end
end
