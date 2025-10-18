class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  def home
    render "home/index" # cria a view em app/views/home/index.html.erb
  end
end
