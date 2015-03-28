require "rails_helper"

describe "Answers" do

  context "check" do

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
