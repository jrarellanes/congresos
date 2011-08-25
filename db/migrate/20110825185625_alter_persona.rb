class AlterPersona < ActiveRecord::Migration
  def change
    add_column :personas, :rfc, :string
    add_column :personas, :curp, :string
    add_column :personas, :calle, :string
    add_column :personas, :numero, :integer
    add_column :personas, :cp, :integer
    add_column :personas, :institucion, :string
    add_column :personas, :ciudad, :string
  end
end
