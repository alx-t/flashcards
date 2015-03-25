require "rails_helper"

describe "Card" do

  context "check on home page" do

    it "without card" do
      visit root_path
      expect(page).to have_content "Карточек на сегодня нет"
    end

    context "with card" do

      before(:each) do
        FactoryGirl.create(:card)
        visit root_path
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