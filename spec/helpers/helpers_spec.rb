module Helpers
  def login(email, password)
    visit root_path
    click_link "Войти"
    fill_in :email, with: email
    fill_in :password, with: password
    click_button "Войти"
  end

  def registration(user, password)
    click_link "Регистрация"
    fill_in :user_email, with: user
    fill_in :user_password, with: password
    fill_in :user_password_confirmation, with: password
    click_button "Сохранить"
  end
end 