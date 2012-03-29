class AddCongresoIdToGradosEstudio < ActiveRecord::Migration
  def change
    add_column :grado_estudios, :congreso_id, :integer
  end
end
