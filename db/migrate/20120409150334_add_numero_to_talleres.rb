class AddNumeroToTalleres < ActiveRecord::Migration
  def change
    add_column :talleres, :numero, :integer
  end
end
