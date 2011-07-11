class CreatePaises < ActiveRecord::Migration
  def change
    create_table :paises do |t|
      t.string :siglas, :limit => 20
      t.string :nombre, :limit => 100
      t.timestamps
    end
  end
end
