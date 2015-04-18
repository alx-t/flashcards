require "rails_helper"

describe "Users" do

  context "check" do
    before(:each) do
      visit root_path
      select "Русский", from: "new_locale"
    end

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
      expect(page).to have_content I18n.t(:welcome)
    end

    it "failed login" do
      create(:user)
      login("user_example.com", "password")
      expect(page).to have_content I18n.t(:fl_data_err)
    end

    it "logout" do
      create(:user)
      login("user@example.com", "password")
      click_link I18n.t('.layouts.application.logout')
      expect(page).to have_content I18n.t('.home.landing.sign_in')
    end
  end
end
