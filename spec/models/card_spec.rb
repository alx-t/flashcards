require 'rails_helper'

describe Card do

  let(:card) { FactoryGirl.create(:card) }

  subject { card }

  it { should respond_to(:original_text) }
  it { should respond_to(:translated_text) }
  it { should respond_to(:review_date) }

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
      it { should_not be_valid}
    end
  end

  context "check answer" do

    it "uppercase text right answer" do
      expect(card.check_translation("TeSt")).to be true
    end

    it "right answer" do
      expect(card.check_translation("test")).to be true
    end

    it "wrong answer" do
      expect(card.check_translation("book")).to be false
    end

    context "russian text" do
      before(:each) { card.original_text = "тест"}

      it "uppercase text right answer" do
        expect(card.check_translation("ТесТ")).to be true
      end

      it "wrong answer" do
        expect(card.check_translation("Дом")).to be false
      end
    end

    context "checking review date" do
      before(:each) { card.review_date = Time.now - 3.days}

      it "changing if right answer" do
        card.check_translation("test")
        expect(card.review_date).to be >= Time.now
      end

      it "not changing if wrong answer" do
        card.check_translation("book")
        expect(card.review_date).to be <= Time.now
      end
    end
  end
end
