class CreateAreaExteriores < ActiveRecord::Migration
  def change
    create_table :area_exteriores do |t|
      t.string :concepto, null:false
      t.float :desde, null:false
      t.float :hasta, null:true
      t.float :porcentaje_concepto, null:false
      t.references :created_by, index:true,  null:false
      t.timestamps null: false
    end
  end
end
