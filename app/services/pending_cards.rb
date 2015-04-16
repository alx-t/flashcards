class PendingCards

  def self.check
    users = User.joins(:cards).merge(Card.active).distinct
    #User.joins(:cards).where("review_date <= ?", Time.now).distinct
    # User.joins(:cards).merge(Card.active)
    users.each { |user| NotificationsMailer.pending_cards(user).deliver_now }
  end
end
