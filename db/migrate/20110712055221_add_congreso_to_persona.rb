class AddCongresoToPersona < ActiveRecord::Migration
  def change
    add_column :personas, :congreso_id, :integer
  end
end
