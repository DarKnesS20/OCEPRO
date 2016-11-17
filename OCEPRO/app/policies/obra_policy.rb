class ObraPolicy < ApplicationPolicy
	def index?
    true
	end

  def aranceles?
    !usuario.agremiado?
  end

  def show?
    true
  end

  def new?
    usuario.agremiado?
  end

  def edit?
    usuario.operador? || usuario.agremiado? || usuario.admin? || usuario.system?
  end

  def create?
    new?
  end

  def visar?
    !usuario.agremiado? && record.en_proceso?
  end

  def update?
    edit?
  end
  
  def oceprone?
    edit?
  end
  def destroy?
    !record.pagado?
  end

  def rechazar?
    !usuario.agremiado? && !record.pagado?
  end

  def pagar?
    !usuario.agremiado? && record.visado?
  end

  def regresion_lineal?
    usuario.system? || usuario.admin? 
  end
  
  def estadisticas?
    usuario.system? || usuario.admin?
  end

  class Scope < Scope
    def resolve
      if usuario.agremiado?
        scope.where(coordinador_proyecto: @usuario)
      else
        scope.where('status_obra <> ?', :creado)
      end
    end
  end
end

