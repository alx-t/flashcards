require 'rails_helper'

describe "Card" do

  let(:card) { create(:card) }

  subject { card }
  it { should be_valid }

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
      expect(card.check_translation("TeSt")).to be true
    end

    context "russian text" do
      before(:each) { card.original_text = "тест" }

      it "uppercase text right answer" do
        expect(card.check_translation("ТесТ")).to be true
      end

      it "wrong answer" do
        expect(card.check_translation("Дом")).to be false
      end
    end

    context "after right answers" do
      before(:each) do
        card.review_date = Time.now - 3.days
        card.check_translation("test")
      end

      it "attempts" do
        expect(card.attempts).to eq(0)
      end

      it "repetition number" do
        expect(card.repetition_number).to eq(1)
      end

      it "review date" do
        expect(card.review_date).to be >= Time.now
      end
    end

    context "after wrong answers" do
      before(:each) do
        card.review_date = Time.now - 3.days
        card.check_translation("book")
      end

      it "attempts" do
        expect(card.attempts).to eq(1)
      end

      it "repetition number" do
        expect(card.repetition_number).to eq(0)
      end

      it "review date" do
        expect(card.review_date).to be <= Time.now
      end
    end

    context "wrong answer after 3 attempts" do
      before(:each) do
        card.review_date = Time.now - 3.days
        card.attempts = 3
        card.check_translation("book")
      end

      it "attempts" do
        expect(card.attempts).to eq(0)
      end

      it "review date added 12 hours" do
        expect(card.review_date >= Time.now + 12.hours - 1.minute).to be true
      end

      it "repetition number" do
        expect(card.repetition_number).to eq(1)
      end
    end

    context "right answer after 3 repetition" do
      before(:each) do
        card.review_date = Time.now - 3.days
        card.repetition_number = 3
        card.check_translation("test")
      end

      it "attempts" do
        expect(card.attempts).to eq(0)
      end

      it "review date added 2 weeks" do
        expect(card.review_date >= Time.now + 2.weeks - 1.minute).to be true
      end

      it "repetition number" do
        expect(card.repetition_number).to eq(4)
      end
    end

    context "right answer after 7 repetition" do
      before(:each) do
        card.review_date = Time.now - 3.days
        card.repetition_number = 7
        card.check_translation("test")
      end

      it "attempts" do
        expect(card.attempts).to eq(0)
      end

      it "review date added 2 weeks" do
        expect(card.review_date >= Time.now + 1.month - 1.minute).to be true
      end

      it "repetition number" do
        expect(card.repetition_number).to eq(8)
      end
    end
  end
end
