require 'rails_helper'

describe "SuperMemo" do

  let(:card) { create(:card) }

  context "1st right answer with answer time < 5c" do
    before(:each) do
      card.check_translation("test", 4)
    end

    it "card attempts should be 1" do
      expect(card.attempts).to eq(1)
    end

    it "card efactor not changed end equal 2.5" do
      expect(card.efactor).to eq(2.5)
    end

    it "card interval should be 1" do
      expect(card.interval).to eq(1)
    end

    it "card review_date should be added 1 day " do
      expect(card.review_date >= Time.now + 1.day - 1.minute).to be true
    end
  end

  context "2nd right answer with answer time > 10c" do
    before(:each) do
      card.attempts = 1
      card.interval = 1
      card.check_translation("test", 15)
    end

    it "card attempts should be 2" do
      expect(card.attempts).to eq(2)
    end

    it "card efactor not changed end equal 2.5" do
      expect(card.efactor).to eq(2.5)
    end

    it "card interval should be 6" do
      expect(card.interval).to eq(6)
    end

    it "card review_date should be added 6 day " do
      expect(card.review_date >= Time.now + 6.day - 1.minute).to be true
    end
  end

  context "3rd right answer with answer time > 10c" do
    before(:each) do
      card.attempts = 2
      card.interval = 6
      card.check_translation("test", 14)
    end

    it "card attempts should be 3" do
      expect(card.attempts).to eq(3)
    end

    it "card efactor should be changed end equal 2.36" do
      expect(card.efactor).to eq(0.236E1)
    end

    it "card interval should be 14" do
      expect(card.interval).to eq(14)
    end

    it "card review_date should be added 14 day " do
      expect(card.review_date >= Time.now + 14.day - 1.minute).to be true
    end
  end

  context "3rd attempts and wrong answer" do
    before(:each) do
      card.attempts = 2
      card.interval = 6
      card.check_translation("wrong", 14)
    end

    it "card attempts should be 0" do
      expect(card.attempts).to eq(0)
    end

    it "card efactor should be start value and equal 2.5" do
      expect(card.efactor).to eq(0.25E1)
    end

    it "card interval should be 0" do
      expect(card.interval).to eq(0)
    end

    it "card review_date should be < Time.now" do
      expect(card.review_date <= Time.now).to be true
    end
  end
end
