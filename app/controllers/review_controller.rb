class ReviewController < ApplicationController
  def check
    @card = current_user.cards.find(card_params[:card_id])
    check_answer(@card.check_translation(card_params[:original_text],
                                         card_params[:answer_time]))
    redirect_to root_path
  end

  private

  def card_params
    params.permit(
      card_id: Parameters.id,
      original_text: Parameters.string,
      answer_time: Parameters.id)
  end

  def check_answer(result)
    case [result[:success], result[:typos_count]]
    when [true, 0]
      flash[:success] = t :fl_right_translation,
                          original: @card.original_text,
                          translation: @card.translated_text
    when [true, 1]
      flash[:success] = t :fl_right_translation_typos,
                          original: @card.original_text,
                          translation: @card.translated_text,
                          typo: card_params[:original_text]
    else
      flash[:danger] = t(:fl_wrong_translation)
    end
  end
end
