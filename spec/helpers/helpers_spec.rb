module Helpers
  def login(email, password)
    visit root_path
    click_link I18n.t(".layouts.application.login")
    fill_in :email, with: email
    fill_in :password, with: password
    click_button I18n.t(".user_sessions.new.sign_in")
  end

  def registration(user, password)
    click_link I18n.t(".layouts.application.registration")
    fill_in :user_email, with: user
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password
    click_button I18n.t(:submit)
  end
end
