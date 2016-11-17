class AddValidTimestampsToCostos < ActiveRecord::Migration
  def change
  	add_column :costos, :valido_desde, :timestamp, null:false
  	add_column :costos, :valido_hasta, :timestamp
  end
end
