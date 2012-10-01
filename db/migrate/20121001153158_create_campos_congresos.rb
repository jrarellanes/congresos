class CreateCamposCongresos < ActiveRecord::Migration
    def up
    create_table :campos_congresos, :id => false do |t|
      t.integer :congreso_id
      t.integer :campo_id
      t.timestamps
    end
  end

  def down
  end
end
