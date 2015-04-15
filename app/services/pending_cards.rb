class PendingCards

  def self.check
    User.all.each do |user|
      unless user.cards_for_review.empty?
        NotificationsMailer.pending_cards(user).deliver_now
      end
    end
  end
end
