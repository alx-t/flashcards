require "rails_helper"

describe "Cards" do

  context "check" do

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
end