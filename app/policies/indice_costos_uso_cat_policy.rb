class IndiceCostosUsoCatPolicy < ApplicationPolicy
	def index?
    usuario.system? || usuario.admin? || usuario.operador?
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


end