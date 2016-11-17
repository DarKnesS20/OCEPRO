class AddPorcentajeTablaDatosToVisados < ActiveRecord::Migration
  def change
  	add_column :visados, :porcentaje_tabla_datos, :float
  end
end
