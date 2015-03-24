class ReviewController < ApplicationController
  def check
    card = Card.find(card_params[:card_id])
    if card.check_translation(card_params[:original_text])
      flash[:success] = "Правильно!"
    else
      flash[:danger] = "Не правильно!"
    end
    redirect_to root_path
  end

  private

    def card_params
      params.permit(:card_id, :original_text)
    end
end
