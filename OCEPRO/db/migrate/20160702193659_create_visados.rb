class CreateVisados < ActiveRecord::Migration
  def change
    create_table :visados do |t|

      t.references :obra, index:true, null: false
   	  t.float :area_bruta, null:false
   	  t.string :tipo, null:false
   	  t.float  :complejidad, null:false
   	  t.float :costo_construccion_estimado, null:false
   	  t.float :costo_estimado_proyecto
   	  t.float :costo_completo, null:false
   	  t.boolean :es_repeticion, null:false, default:false
   	  t.integer :cantidad_repeticiones
   	  t.float :costo_completo_repeticion
   	  t.float :arancel 
   	  t.references :created_by, index:true, null:false
   	  t.references :updated_by, index:true, null:false
      t.timestamps null: false
    end
  end
end
