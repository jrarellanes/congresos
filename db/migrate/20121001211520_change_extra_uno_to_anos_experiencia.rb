class ChangeExtraUnoToAnosExperiencia < ActiveRecord::Migration
  def change
    remove_column :personas, :extra_uno
    add_column :personas, :anos_experiencia, :string
  end
end
