class AddNombreConstanciaToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :nombre_constancia, :string
  end
end
