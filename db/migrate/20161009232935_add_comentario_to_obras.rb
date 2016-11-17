class AddComentarioToObras < ActiveRecord::Migration
  def change

  	add_column :obras, :comentario, :text
  end
end
