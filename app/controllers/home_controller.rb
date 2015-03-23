class HomeController < ApplicationController
  def index
    @card = Card.active.first
  end
end
