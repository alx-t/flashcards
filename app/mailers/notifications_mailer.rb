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
      file_name = "#{Rails.root}/public#{card.image_url(:thumb)}"
      if File.exists?(file_name)
        attachments.inline["#{card.image_url(:thumb)}"] = File.read(file_name)
      end
    end
  end
end
