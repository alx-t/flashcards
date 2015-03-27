require "rails_helper"

describe "Card" do

  context "check users" do
    before(:each) { visit root_path }

    it "when user is not logged in" do
      expect(page).to have_content "Зарегистрируйтесь или войдите для начала работы с карточками"
    end

    it "successful registration" do
      registration("user@example.com", "password")
      expect(page).to have_content "Пользователь зарегистрирован!"
    end

    it "failed registration" do
      registration("user_example.com", "password")
      expect(page).to have_content "Ошибка в данных!"
    end

    it "successful login" do      
      FactoryGirl.create(:user)
      login("user@example.com", "password")
      expect(page).to have_content "Добро пожаловать!"
    end

    it "failed login" do
      FactoryGirl.create(:user)
      login("user_example.com", "password")
      expect(page).to have_content "Неправильный логин или пароль!"
    end

    it "logout" do
      FactoryGirl.create(:user)
      login("user@example.com", "password")
      click_link "Выйти"
      expect(page).to have_content "Зарегистрируйтесь или войдите для начала работы с карточками"
    end
  end

  context "check cards" do

    before(:each) do
      FactoryGirl.create(:card)
      login("user@example.com", "password")
    end

    it "new card" do
      visit root_path
      expect(page).to have_content "Добавить карточку"
      click_link "Добавить карточку"
      fill_in :card_original_text, with: "test"
      fill_in :card_translated_text, with: "тест"
      click_button "Сохранить"
      expect(page).to have_content "Карточка добавлена!"
    end

    it "update card" do
      visit cards_path
      click_link "Изменить"
      fill_in :card_original_text, with: "test"
      fill_in :card_translated_text, with: "тест"
      click_button "Сохранить"
      expect(page).to have_content "Карточка обновлена!"
    end

    it "delete card" do
      visit cards_path
      click_link "Удалить"
      expect(page).to have_content "Карточка удалена!"
    end
  end

  context "check answers" do
    
    it "without card" do
      FactoryGirl.create(:user)
      login("user@example.com", "password")
      expect(page).to have_content "Карточек на сегодня нет"
    end

    context "with card" do

      before(:each) do
        FactoryGirl.create(:card)
        login("user@example.com", "password")
      end

      it "with wrong answer" do
        fill_in "original_text", with: "Wrong answer"
        click_button "Проверить!"
        expect(page).to have_content "Не правильно!"
      end

      it "with right answer" do
        fill_in "original_text", with: "TeSt"
        click_button "Проверить!"
        expect(page).to have_content "Правильно!"
      end
    end
  end
end