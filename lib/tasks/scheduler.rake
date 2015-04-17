desc "Notification users about pending cards for the Heroku scheduler add-on"
task send_notification: :environment do
  User.send_pending_card_notification
end