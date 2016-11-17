class UsuarioPolicy < ApplicationPolicy
	def index?
    usuario.system? || usuario.admin? || usuario.operador?
	end

  def show?
    true
  end

  def new?
    index?
  end

  def edit?
    true
  end

  def create?
    new?
  end

  def update?
    true
  end

  def destroy?
    false
  end

  #def archive?
  #  index?
  #end
  class Scope < Scope
    def resolve
      scope.where('role >= ?', Usuario.roles[usuario.role])
    end
  end
end
