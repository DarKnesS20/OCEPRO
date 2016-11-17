class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include Filterable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:system, :admin, :operador, :agremiado]
  has_many :obras, class_name: :Obra, foreign_key: 'coordinador_proyecto_id'

  scope :usuario, -> (usuario) {where(usuario: usuario)}
  scope :nombres, -> (nombres) {where('nombres like ?', '%'+nombres+'%')}
  scope :cedula, -> (cedula) {where(cedula: cedula)}
  scope :civ, -> (civ) {where(civ: civ)}
  scope :email, -> (email) {where(email: email)}
  scope :agremiados, -> {where(role: 3)}


  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :agremiado	
  end

  def roll_usuarios
    if tipo_usuario
      if tipo_usuario == "AGREMIADO"
        3
      elsif tipo_usuario == "OPERADOR"
        2
      elsif tipo_usuario == "SUPERVISOR"
        1
      end
    end
  end

  # instead of deleting, indicate the user requested a delete & timestamp it  
  def soft_delete  
    update_attribute(:deleted_at, Time.current)  
  end  

  # ensure user account is active  
  def active_for_authentication?  
    super && !deleted_at  
  end  

  # provide a custom message for a deleted account   
  def inactive_message   
    !deleted_at ? super : :deleted_account  
  end  
end
