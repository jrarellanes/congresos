class AddDescuentoToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :descuento, :boolean, {:default => false}
  end
end
