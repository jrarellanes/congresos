class AddToCongresos < ActiveRecord::Migration
    def up
      add_column :congresos, :fecha_inicio, :datetime
      add_column :congresos, :fecha_fin, :datetime
      add_column :congresos, :lugar, :string
    end
 

  def down
  end
end
