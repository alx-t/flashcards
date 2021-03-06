require "rails_helper"

describe "Answers" do

  context "check" do
    it "without card" do
      create(:user)
      login("user@example.com", "password")
      expect(page).to have_content "Карточек на сегодня нет"
    end

    context "with card" do
      before(:each) do
        create(:card)
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

    context "current pack" do
      let(:user) { create(:user) }
      let(:pack) { create(:pack, title: "pack", user: user) }
      let(:current_pack) { create(:pack, title: "current pack", user: user) }

      it "card" do
        create(:card, pack: pack, original_text: "test")
        create(:card, pack: current_pack, original_text: "current")
        user.update_attributes(current_pack: current_pack)
        login("user@example.com", "password")
        fill_in "original_text", with: "current"
        click_button "Проверить!"
        expect(page).to have_content "Правильно!"
      end
    end
  end
end
