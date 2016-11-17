class CreateObras < ActiveRecord::Migration
  def change
    create_table :obras do |t|

      t.string :nombre,             null: false
      t.string :propietario_parcela_nombre,null: false
      t.string :propietario_parcela_ci,    null: false
      t.references :coordinador_proyecto, index:true, null: false
      t.string :residente_obra_nombre
      t.string :residente_obra_civ
      t.string :direccion_obra,            null: false
      t.string :municipio_obra,            null: false
      t.string :uso_obra,                  null: false
      t.string :memoria_descriptiva,       null:false
      t.integer :n_oceprone
      t.float :area_parcela, null:false
      t.float :area_bruta_construccion, null:false
      t.float :area_neta_construccion, null:false
      t.string :status_obra, null:false 
      t.timestamps null: false
    end
  end
end
