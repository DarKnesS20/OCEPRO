class HonorarioMinimo < ActiveRecord::Base
	has_many :honorarios_min_distancia_visados
	has_many :visados, through: :honorarios_min_distancia_visados
	belongs_to :created_by, class_name: :Usuario

	scope :visado, -> (tv) { where(tipo_visado: tv) }
	scope :costo, -> (c) { where('desde <= ? AND ? < hasta', c, c) }
	
	
end
