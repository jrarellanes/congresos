class AddImagenToCongresos < ActiveRecord::Migration
  def change
    add_column :congresos, :imagen_file_name, :string
    add_column :congresos, :imagen_content_type, :string
    add_column :congresos, :imagen_file_size, :integer
    add_column :congresos, :imagen_updated_at, :datetime
  end
end
