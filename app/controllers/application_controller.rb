class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login
  before_action :set_locale

  private

  def set_locale
    locale = if current_user
                if current_user.locale
                  current_user.locale
                else
                  http_accept_language.compatible_language_from(I18n.available_locales)
                end
              elsif session[:locale]
                session[:locale]
              else
                http_accept_language.compatible_language_from(I18n.available_locales)
              end

    if locale && I18n.available_locales.include?(locale.to_s.to_sym)
      session[:locale] = I18n.locale = locale.to_sym
    end
  end
end
