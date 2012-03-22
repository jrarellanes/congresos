class AddNombreToGradoEstudio < ActiveRecord::Migration
  def change
    add_column :grado_estudios, :nombre, :string
  end
end
