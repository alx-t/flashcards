class ReviewController < ApplicationController
  def check
    card = Card.find(params[:card_id])
    if card.correct_answer_update?(params[:original_text])
      flash[:success] = "Правильно!"
    else
      flash[:danger] = "Не правильно!"
    end
    redirect_to root_path
  end
end
