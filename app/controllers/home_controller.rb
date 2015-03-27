class HomeController < ApplicationController
  skip_before_filter :require_login

  def index
    @card = Card.active.first
  end
end
