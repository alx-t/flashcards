class PendingCards

  def self.check
    users = User.joins(:cards).merge(Card.active).distinct
    users.each { |user| NotificationsMailer.pending_cards(user).deliver_now }
  end
end
