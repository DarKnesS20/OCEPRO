class HomeController < ApplicationController
  def index
  	
    redirect_to new_usuario_session_url if not usuario_signed_in?
  end
end

