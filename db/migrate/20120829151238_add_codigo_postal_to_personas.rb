class AddCodigoPostalToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :codigo_postal, :string
  end
end
