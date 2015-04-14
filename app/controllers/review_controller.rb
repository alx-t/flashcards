class ReviewController < ApplicationController
  def check
    card = current_user.cards.find(card_params[:card_id])
    result = card.check_translation(card_params[:original_text])
    case [result[:success], result[:typos_count]]
    when [true, 0]
      flash[:success] = "Правильно! \
                         Слово: #{card.original_text}, \
                         Перевод: #{card.translated_text}"
    when [true, 1]
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
