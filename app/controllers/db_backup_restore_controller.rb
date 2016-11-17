class DbBackupRestoreController < ApplicationController
  before_filter :authenticate_usuario!
	def backup
    success = DbBackupRestore.backup
		respond_to do |format|
      format.json { render json: success}
    end
	end

	def restore	
    success = DbBackupRestore.restore
    respond_to do |format|
      format.json { render json: success}
    end
	end
end