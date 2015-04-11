class HomeController < ApplicationController
  skip_before_action :require_login

  def index
    if current_user
      @card = current_user.card_for_review
    else
      redirect_to landing_path
    end
  end

  def landing
  end
end
