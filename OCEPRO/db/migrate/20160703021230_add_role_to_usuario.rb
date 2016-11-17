class AddRoleToUsuario < ActiveRecord::Migration
  def change
  	add_column :usuarios, :role, :integer, default: 3
  end
end
