class AddTipoAreaToAreaExteriores < ActiveRecord::Migration
  def change
  	add_column :area_exteriores, :tipo_area, :string
  end
end
