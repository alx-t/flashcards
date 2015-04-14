class ReviewController < ApplicationController
  def check
    card = current_user.cards.find(card_params[:card_id])
    case card.check_translation(card_params[:original_text])
    when 0
      flash[:success] = "Правильно! \
                         Слово: #{card.original_text}, \
                         Перевод: #{card.translated_text}"
    when 1
      flash[:success] = "Правильно! \
                         Слово: #{card.original_text}, \
                         Перевод: #{card.translated_text}, \
                         Ошибка ввода: #{card_params[:original_text]}"
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
