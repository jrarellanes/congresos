class CreateHorariosPersonas < ActiveRecord::Migration
  def up
    create_table :horarios_personas, :id => false do |t|
      t.integer :persona_id
      t.integer :horario_id
      t.timestamps
    end
  end

  def down
    drop_table :horarios_personas
  end
end
