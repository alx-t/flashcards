class HomeController < ApplicationController
  skip_before_action :require_login

  def index
    if current_user
      @card = current_user.cards_for_review.random.first
    else
      redirect_to landing_path
    end
  end

  def landing
  end

  def change_locale
    session[:locale] = params[:new_locale]
    redirect_to landing_path
  end
end
