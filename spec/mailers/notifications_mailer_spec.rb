require "rails_helper"

describe "Mailer" do

  let!(:user) { create(:user) }
  let!(:current_pack) { create(:pack, title: "current pack", user: user) }
  let!(:card) { create(:card,
                        pack: current_pack,
                        original_text: "current",
                        review_date: Time.now - 3.days) }
  let!(:mailer) { NotificationsMailer.pending_cards(user) }

  context "send pending card" do

    it "renders the subject" do
      expect(mailer.subject).to eql("#{Time.now.strftime('%d/%m/%Y')} Карточки к просмотру")
    end

    it "renders the sender" do
      expect(mailer.from).to eql(["admin@flashcards.com"])
    end

    it "renders the user email" do
      expect(mailer.to).to eql([user.email])
    end

    it "renders the card in body" do
        expect(mailer.body.encoded).to include(card.translated_text)
    end
  end
end
