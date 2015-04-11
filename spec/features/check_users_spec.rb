require "rails_helper"

describe "Users" do

  context "check" do
    before(:each) { visit root_path }

    it "when user is not logged in" do
      expect(page).to have_content "Зарегистрируйтесь или войдите для \
        начала работы с карточками"
    end

    it "successful registration" do
      registration("user@example.com", "password")
      expect(page).to have_content "Пользователь зарегистрирован!"
    end

    it "failed registration" do
      registration("user@example.com", "")
      expect(page).to have_content "Ошибка в данных!"
    end

    it "successful login" do
      create(:user)
      login("user@example.com", "password")
      expect(page).to have_content "Добро пожаловать!"
    end

    it "failed login" do
      create(:user)
      login("user_example.com", "password")
      expect(page).to have_content "Неправильный логин или пароль!"
    end

    it "logout" do
      create(:user)
      login("user@example.com", "password")
      click_link "Выйти"
      expect(page).to have_content "Зарегистрируйтесь или войдите для \
        начала работы с карточками"
    end
  end
end
