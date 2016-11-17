class Visado < ActiveRecord::Base
  include Filterable
	belongs_to :created_by, class_name: :Usuario
	belongs_to :updated_by, class_name: :Usuario
	belongs_to :obra, class_name: :Obra
  has_many :honorarios_min_distancia_visados
  has_many :honorario_minimos, through: :honorarios_min_distancia_visados

  scope :civ, -> (civ) {joins('JOIN obras ON visados.obra_id = obras.id').joins('JOIN usuarios ON obras.coordinador_proyecto_id = usuarios.id').where('usuarios.civ = ?',civ)}
  scope :tipo, -> (tipo) {where(tipo: tipo)}
  scope :desde, -> (timestamp) { where('created_at >= ?', timestamp) }
  scope :hasta, -> (timestamp) { where('created_at <= ?', timestamp) }
  scope :nombres, -> (nombres) {joins('JOIN obras ON visados.obra_id = obras.id').joins('JOIN usuarios ON obras.coordinador_proyecto_id = usuarios.id').where('usuarios.nombres like ?', '%'+nombres+'%')}


	def honorario_por_repeticion
		if es_repeticion
      if cantidad_repeticiones == 1
        0.60
      elsif cantidad_repeticiones == 2
        1.10
      elsif cantidad_repeticiones == 3
        1.50
      elsif cantidad_repeticiones == 4
        1.80
      elsif cantidad_repeticiones == 5
        2.00
      elsif cantidad_repeticiones == 6
        2.10
      elsif cantidad_repeticiones > 6
        ((cantidad_repeticiones - 6) * 0.10 ) + 2.10
      end
    end
	end
end
