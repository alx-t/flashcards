require "rails_helper"

describe "Packs" do

  context "check" do
    before(:each) do
      create(:pack)
      login("user@example.com", "password")
    end

    it "new pack" do
      visit root_path
      click_link "Добавить колоду"
      fill_in :pack_title, with: "Первая"
      click_button "Сохранить"
      expect(page).to have_content "Колода создана!"
    end

    it "set current pack" do
      visit packs_path
      click_link "Сделать текущей"
      expect(page).to have_content "Отмена текущей"
    end

    it "reset current pack" do
      visit packs_path
      click_link "Сделать текущей"
      click_link "Отмена текущей"
      expect(page).to have_content "Сделать текущей"
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
