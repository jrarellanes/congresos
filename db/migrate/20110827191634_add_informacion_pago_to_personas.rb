class AddInformacionPagoToPersonas < ActiveRecord::Migration
  def change
    add_column :personas, :informacion_pago, :string
  end
end
