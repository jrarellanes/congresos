class AddAttachmentComprobantePagoToPersona < ActiveRecord::Migration
  def self.up
    add_column :personas, :comprobante_pago_file_name, :string
    add_column :personas, :comprobante_pago_content_type, :string
    add_column :personas, :comprobante_pago_file_size, :integer
    add_column :personas, :comprobante_pago_updated_at, :datetime
  end

  def self.down
    remove_column :personas, :comprobante_pago_file_name
    remove_column :personas, :comprobante_pago_content_type
    remove_column :personas, :comprobante_pago_file_size
    remove_column :personas, :comprobante_pago_updated_at
  end
end
