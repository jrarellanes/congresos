class AddRequiereHorarioToCongresos < ActiveRecord::Migration
  def change
    add_column :congresos, :requiere_horario, :boolean
  end
end
