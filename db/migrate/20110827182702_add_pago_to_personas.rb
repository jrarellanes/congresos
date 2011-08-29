class AddPagoToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :pago, :boolean, :default => false
  end
end
