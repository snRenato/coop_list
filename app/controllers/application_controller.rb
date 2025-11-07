class ApplicationController < ActionController::Base
   before_action :set_locale
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  include Pundit::Authorization
  # Isso captura o erro e retorna 403 em vez de redirecionar
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?
  def home
    render "home/index" # cria a view em app/views/home/index.html.erb
  end

  private

  def user_not_authorized
    respond_to do |format|
      format.html { head :forbidden }
      format.turbo_stream { head :forbidden }
      format.json { head :forbidden }
    end
  end

    def set_locale
      I18n.locale = :'pt-BR'
    end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name ])
  end
end
