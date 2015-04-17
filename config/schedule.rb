every 1.day, at: "8:30 am" do
  runner "User.send_pending_card_notification"
end
