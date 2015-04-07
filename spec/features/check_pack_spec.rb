require "rails_helper"

describe "Packs" do

  context "check" do
    before(:each) do
      FactoryGirl.create(:pack)
      login("user@example.com", "password")
    end

    it "new pack" do
      visit root_path
      click_link "Добавить колоду"
      fill_in :pack_title, with: "Первая"
      check :pack_current
      click_button "Сохранить"
      expect(page).to have_content "Колода создана!"
    end

    it "update pack" do
      visit packs_path
      click_link "Изменить"
      fill_in :pack_title, with: "Вторая"
      click_button "Сохранить"
      expect(page).to have_content "Колода обновлена!"
    end

    it "delete pack" do
      visit packs_path
      click_link "Удалить"
      expect(page).to have_content "Колода удалена!"
    end
  end
end
