class CreateCostos < ActiveRecord::Migration
  def change
    create_table :costos do |t|
      t.string :descripcion, null:false
      t.float :costos, null:false
      t.references :created_by, index:true,  null:false
      t.timestamps null: false
    end
  end
end
