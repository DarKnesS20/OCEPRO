class HonorariosMinDistanciaVisado < ActiveRecord::Base
	belongs_to :honorario_minimo, class_name: :HonorarioMinimo
	belongs_to :visado, class_name: :Visado
end
