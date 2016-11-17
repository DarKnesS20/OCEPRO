class CreateHonorarioMinimos < ActiveRecord::Migration
  def change
    create_table :honorario_minimos do |t|
      t.string :concepto, null:false
      t.float :desde, null:false
      t.float :hasta
      t.float :porcentaje, null:false
      t.references :created_by, index:true,  null:false
      t.timestamps null: false
    end
  end
end
