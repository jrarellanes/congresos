class AddPagoToCongresos < ActiveRecord::Migration
  def change
    add_column :congresos, :pago, :boolean
  end
end
