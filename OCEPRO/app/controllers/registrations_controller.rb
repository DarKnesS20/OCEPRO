class RegistrationsController < Devise::RegistrationsController

 	skip_before_filter :require_no_authentication
  	before_filter  :authenticate_scope!


  	protected

	def sign_up(resource_name, resource)
	#'/sign_in'		
	end

	def after_sign_up_path_for(resource)
    	usuarios_path
  	end
  	
end

