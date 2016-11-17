class DbBackupRestorePolicy < ApplicationPolicy

  def backup
    usuario.system? 
  end

  def restore	
    usuario.system? 
  end

end
