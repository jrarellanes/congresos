class AddNombreGafeteToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :nombre_gafete, :string
  end
end
