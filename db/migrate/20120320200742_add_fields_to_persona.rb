class AddFieldsToPersona < ActiveRecord::Migration
  def change
    add_column :personas, :extra_uno, :string
    add_column :personas, :telefono, :string
    add_column :personas, :grado_estudio_id, :integer
  end
end
