class AddPagoToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :pago, :string, :default =>""
  end
end
