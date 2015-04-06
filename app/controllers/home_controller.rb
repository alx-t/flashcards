class HomeController < ApplicationController
  skip_before_action :require_login

  def index
    @card = current_user.card_for_review if current_user
  end
end
