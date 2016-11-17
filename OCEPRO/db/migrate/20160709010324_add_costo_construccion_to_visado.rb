class AddCostoConstruccionToVisado < ActiveRecord::Migration
  def change
  	add_column :visados, :costo_construccion, :float, null:false
  end
end
