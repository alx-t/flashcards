require 'rails_helper'

describe "Card" do

  let(:card) { create(:card) }

  subject { card }
  it { should be_valid }

  context "creating new card" do

    it "efactor should be 2.5" do
      expect(card.efactor).to eq(2.5)
    end

    it "attempts should be 0" do
      expect(card.attempts).to eq(0)
    end

    it "interval should be 0" do
      expect(card.interval).to eq(0)
    end
  end

  context "validating" do
    context "when original_text is not present" do
      before { card.original_text = "" }
      it { should_not be_valid }
    end

    context "when translated_text is not present" do
      before { card.translated_text = "" }
      it { should_not be_valid }
    end

    context "when review_date is not present" do
      before { card.review_date = "" }
      it { should_not be_valid }
    end

    context "translated text not equal original" do
      before { card.translated_text = "TeSt" }
      it { should_not be_valid }
    end

    context "translated text not equal original in russian" do
      before do
        card.original_text = "Тест"
        card.translated_text = "тЕСт"
      end
      it { should_not be_valid }
    end
  end

  context "check answer" do

    it "uppercase text right answer" do
      expect(card.check_translation("TeSt", 0)[:typos_count]).to eq(0)
    end

    context "russian text" do
      before(:each) { card.original_text = "тест" }

      it "uppercase text right answer" do
        expect(card.check_translation("ТесТ", 0)[:typos_count]).to eq(0)
      end

      it "wrong answer" do
        expect(card.check_translation("Дом", 0)[:typos_count]).to be > 1
      end
    end
  end
end
