class CreatePersonaTipos < ActiveRecord::Migration
  def change
    create_table :persona_tipos do |t|
      t.string      :nombre
      t.string      :siglas
      t.references  :congreso
    end
  end
end
