class AddFieldsToObras < ActiveRecord::Migration
  def change
  	add_column :obras, :residente_ci, :integer
  	add_column :obras, :tipo_ci_juridico, :string
  	add_column :obras, :tipo_ci_residente, :string
  end
end
