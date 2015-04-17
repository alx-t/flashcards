require 'open-uri'

class NotificationsMailer < ApplicationMailer

  def pending_cards(user)
    @user = user
    set_attachments(@user)
    mail(to: @user.email,
         subject: "#{Time.now.strftime('%d/%m/%Y')} Карточки к просмотру")
  end

  private

  def set_attachments(user)
    user.cards_for_review.each do |card|
      next if card.image_url == "default.jpg"
      attachments.inline["#{card.image_url(:thumb)}"] = open("#{card.image_url(:thumb)}").read
    end
  end
end
