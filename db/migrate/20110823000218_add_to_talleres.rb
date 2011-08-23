class AddToTalleres < ActiveRecord::Migration
  def up
    add_column :talleres, :fecha_inicio, :datetime
    add_column :talleres, :fecha_fin, :datetime
    add_column :talleres, :lugar, :string
    add_column :talleres, :hora, :string
  end

  def down
  end
end
