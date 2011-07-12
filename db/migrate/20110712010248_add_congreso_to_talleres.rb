class AddCongresoToTalleres < ActiveRecord::Migration
  def change
    add_column :talleres, :congreso_id, :integer
  end
end
