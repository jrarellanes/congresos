class AddCupoToCongresos < ActiveRecord::Migration
  def change
    add_column :congresos, :cupo, :integer
  end
end
