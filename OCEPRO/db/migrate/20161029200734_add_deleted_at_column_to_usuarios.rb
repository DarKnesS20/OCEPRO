class AddDeletedAtColumnToUsuarios < ActiveRecord::Migration
  def change
    add_column :usuarios, :deleted_at, :datetime
  end
end
