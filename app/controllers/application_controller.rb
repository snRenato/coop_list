class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include Pundit::Authorization

  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  def home
    render "home/index" # cria a view em app/views/home/index.html.erb
  end

  private
  def user_not_authorized
    redirect_to(request.referer || root_path, alert: "Você não tem permissão para acessar esta página.")
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
end
