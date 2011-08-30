class AddPersonaTipoToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :persona_tipo, :integer
  end
end
