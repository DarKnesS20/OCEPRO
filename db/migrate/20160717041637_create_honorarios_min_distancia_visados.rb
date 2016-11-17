class CreateHonorariosMinDistanciaVisados < ActiveRecord::Migration
  def change
    create_table :honorarios_min_distancia_visados do |t|
  	  t.belongs_to :honorario_minimo, index: true
      t.belongs_to :visado, index: true
    end
  end
end
