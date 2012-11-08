class AddCarreraToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :carrera, :string
  end
end
