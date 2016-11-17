class CreateCostosCivs < ActiveRecord::Migration
  def change
    create_table :costos_civs do |t|
      t.float :civ, null:false
      t.references :created_by, index: true, null:false
      t.timestamps null: false
    end
  end
end
