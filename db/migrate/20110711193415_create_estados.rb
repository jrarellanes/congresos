class CreateEstados < ActiveRecord::Migration
  def change
    create_table :estados do |t|
      t.references  :pais
      t.string      :siglas, :limit => 20
      t.string      :nombre, :limit => 100
      t.timestamps
    end
  end
end
