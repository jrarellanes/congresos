class AddEmailToPersona < ActiveRecord::Migration
  def change
    add_column :personas, :email, :string, :limit => 100
    add_column :personas, :pais_id, :integer
    add_column :personas, :estado_id, :integer
    add_column :personas, :municipio_id, :integer
  end
end
