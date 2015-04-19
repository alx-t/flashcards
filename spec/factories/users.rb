FactoryGirl.define do
  factory :user do
    email "user@example.com"
    password "password"
    password_confirmation "password"
    locale "ru"
  end
end
