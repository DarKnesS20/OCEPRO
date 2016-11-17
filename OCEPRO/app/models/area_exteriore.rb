class AreaExteriore < ActiveRecord::Base
	belongs_to :created_by, class_name: :Usuario

	scope :tipo_area, -> (ta) { where(tipo_area: ta) }
    scope :tamano, -> (to) { where('desde <= ? AND ? < hasta', to, to) }
	

end
