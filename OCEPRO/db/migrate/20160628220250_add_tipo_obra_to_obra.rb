class AddTipoObraToObra < ActiveRecord::Migration
  def change
  	add_column :obras, :tipo_obra, :string
  end
end
