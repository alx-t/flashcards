class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = current_user.current_pack.cards
  end

  def new
    @card = current_user.current_pack.cards.new
  end

  def create
    @card = current_user.current_pack.cards.build(card_params)
    if @card.save
      flash[:success] = t(:fl_card_add)
      redirect_to cards_path
    else
      render :new
    end
  end

  def update
    if @card.update(card_params)
      flash[:success] = t(:fl_card_edit)
      redirect_to cards_path
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    flash[:success] = t(:fl_card_delete)
    redirect_to cards_path
  end

  private

  def set_card
    @card = current_user.current_pack.cards.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :image)
  end
end
