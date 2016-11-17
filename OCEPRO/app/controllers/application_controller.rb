class ApplicationController < ActionController::Base
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  #after_action :verify_authorized

  def current_user
  	current_usuario	
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:usuario, :nombres, :apellidos, :cedula, :civ, :email, :password, :tipo_ci_coordinador, :role) }
  end

  private

  def user_not_authorized
    flash[:alert] = "Usted no está autorizado para realizar esta acción."
    redirect_to(request.referrer || root_path)
  end


end
