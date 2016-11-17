class Obra < ActiveRecord::Base
	include Filterable
	include AASM
	
	belongs_to :coordinador_proyecto, class_name: :Usuario
	has_many :visados, class_name: :Visado

	scope :tipo_obra, -> (tipo) {where(tipo_obra: tipo)}
	scope :uso_obra, -> (uso) {where(uso_obra: uso)}
	scope :nombre, -> (nombre) {where(nombre: nombre)}
	scope :usuario_civ, -> (civ) {joins('JOIN usuarios ON obras.coordinador_proyecto_id = usuarios.id').where('usuarios.civ = ?',civ)}
	scope :municipio_obra, -> (municipio) {where(municipio_obra: municipio)}
	scope :desde, -> (timestamp) { where('obras.created_at >= ?', timestamp) }
	scope :hasta, -> (timestamp) { where('obras.created_at <= ?', timestamp) }
	scope :status_obra, -> (status) {where(status_obra: status)}
	scope :direccion_obra, -> (direccion_obra) {where(direccion_obra: direccion_obra)}

	attr_accessor :file

	aasm :column => 'status_obra' do
    state :creado, :initial => true
    state :pendiente, :en_proceso, :visado, :pagado, :rechazado

    event :aprobar_obra do
      transitions :from => :creado, :to => :pendiente
    end

    event :procesar do
      transitions :from => [:pendiente, :en_proceso], :to => :en_proceso
    end

    event :visar do
      transitions :from => :en_proceso, :to => :visado
    end

    event :pagar do
      transitions :from => :visado, :to => :pagado
    end

    event :rechazar do
      transitions :from => [:pendiente, :en_proceso], :to => :rechazado
    end
  end


end


