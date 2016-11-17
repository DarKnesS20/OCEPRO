class CreateIndiceCostosUsoCats < ActiveRecord::Migration
  def change
    create_table :indice_costos_uso_cats do |t|
     
      t.string :vivienda_uso,           null: false
      t.float :indice_complejidad,     null: false
      t.float :indice_costo, null: false

      t.timestamps null: false
    end
  end
end
