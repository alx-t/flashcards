class HomeController < ApplicationController
  skip_before_action :require_login

  def index
    @card = Card.active.first
  end
end
