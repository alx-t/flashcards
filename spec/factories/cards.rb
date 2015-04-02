FactoryGirl.define do
  factory :card do
    original_text   "test"
    translated_text "тест"
    pack

    after(:create) do |card|
      card.update_attributes(review_date: Date.today - 3.days)
    end
  end
end
