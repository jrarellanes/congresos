class AddInstructorToTaller < ActiveRecord::Migration
  def change
    add_column :talleres, :instructor, :string
  end
end
