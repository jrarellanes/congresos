class AddMissingFieldsToPersonaTipo < ActiveRecord::Migration
  def change
    add_column :persona_tipos, :precio, :decimal, :scale => 2, :precision => 10
    add_column :persona_tipos, :estatus_precio, :boolean
  end
end
