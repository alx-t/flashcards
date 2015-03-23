class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      flash[:success] = "Карточка добавлена!"
      redirect_to cards_path
    else
      render :new
    end
  end

  def update
    if @card.update(card_params)
      flash[:success] = "Карточка обновлена!"
      redirect_to cards_path
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    flash[:success] = "Карточка удалена!"
    redirect_to cards_path
  end

  private

    def set_card
      @card = Card.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:original_text, :translated_text)
    end
end
