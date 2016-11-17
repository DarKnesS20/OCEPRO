class VisadoPolicy < ApplicationPolicy
	def index?
    usuario.system? || usuario.admin? || usuario.operador?
	end

  def show?
    index?
  end

  def new?
    index?
  end

  def edit?
    index?
  end

  def create?
    new?
  end

  def update?
    edit?
  end

  def destroy?
    index?
  end

end
