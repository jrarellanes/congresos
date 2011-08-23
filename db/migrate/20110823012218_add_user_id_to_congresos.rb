class AddUserIdToCongresos < ActiveRecord::Migration
  def change
    add_column :congresos, :user_id, :integer
  end
end
