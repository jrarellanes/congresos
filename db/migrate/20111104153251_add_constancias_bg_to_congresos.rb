class AddConstanciasBgToCongresos < ActiveRecord::Migration
  def change
    add_column :congresos, :constancias_bg_file_name, :string
    add_column :congresos, :constancias_bg_content_type, :string
    add_column :congresos, :constancias_bg_file_size, :integer
    add_column :congresos, :constancias_bg_updated_at, :datetime
  end  
end
