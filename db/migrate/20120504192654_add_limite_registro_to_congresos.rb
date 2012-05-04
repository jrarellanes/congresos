class AddLimiteRegistroToCongresos < ActiveRecord::Migration
  def change
    add_column :congresos, :limite_registro, :datetime
  end
end
