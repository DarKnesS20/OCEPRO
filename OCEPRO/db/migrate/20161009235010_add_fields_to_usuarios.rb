class AddFieldsToUsuarios < ActiveRecord::Migration
  def change
  	add_column :usuarios, :tipo_ci_coordinador, :string
  end
end
