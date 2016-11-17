class CreateUsoConstruccions < ActiveRecord::Migration
  def change
    create_table :uso_construccions do |t|

      
      t.string :descripcion_construccion ,null: false
     
    end
  end
end
