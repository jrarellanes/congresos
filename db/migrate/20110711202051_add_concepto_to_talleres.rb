class AddConceptoToTalleres < ActiveRecord::Migration
  def change
    add_column :talleres, :concepto_id, :integer
  end
end
