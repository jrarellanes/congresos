class CreateGradoEstudios < ActiveRecord::Migration
  def change
    create_table :grado_estudios do |t|

      t.timestamps
    end
  end
end
