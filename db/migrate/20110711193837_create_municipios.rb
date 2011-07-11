class CreateMunicipios < ActiveRecord::Migration
  def change
    create_table :municipios do |t|
      t.references  :estado
      t.string      :siglas, :limit => 20
      t.string      :nombre, :limit => 100
      t.timestamps
    end
  end
end
