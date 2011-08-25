class AddPersonaIdToFactura < ActiveRecord::Migration
  def change
    add_column :facturas, :persona_id, :integer
  end
end
