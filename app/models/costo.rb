class Costo < ActiveRecord::Base
	belongs_to :created_by, class_name: :Usuario
end
