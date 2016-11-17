class AddTipoVisadoToHonorarioMinimos < ActiveRecord::Migration
  def change
  	add_column :honorario_minimos, :tipo_visado, :string
  end
end
