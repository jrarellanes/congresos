class CreateUsersCongresos < ActiveRecord::Migration
  def up
    create_table :congresos_users, :id => false do |t|
      t.integer :user_id
      t.integer :congreso_id
      t.timestamps
    end
  end

  def down
  end
end
