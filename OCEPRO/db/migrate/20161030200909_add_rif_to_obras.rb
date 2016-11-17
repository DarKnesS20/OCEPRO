class AddRifToObras < ActiveRecord::Migration
  def change
  	add_column :obras, :rif, :string
  end
end
