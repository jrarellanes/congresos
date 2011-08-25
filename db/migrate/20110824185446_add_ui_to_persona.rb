class AddUiToPersona < ActiveRecord::Migration
  def change
    add_column :personas, :uid, :string
  end
end
