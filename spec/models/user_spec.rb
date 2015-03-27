require 'rails_helper'

describe "User" do

  let(:user) { FactoryGirl.create(:user) }

  subject { user }

  context "validating" do
    context "when email is not present" do
      before { user.email = "" }
      it { should_not be_valid }
    end

    context "when email is invalid" do
      before { user.email = "invalid_email.com" }
      it { should_not be_valid }
    end

    context "when password is not present" do
      before { user.password = "" }
      it { should_not be_valid }
    end

    context "when password_confirmation is not present" do
      before { user.password_confirmation = "" }
      it { should_not be_valid }
    end

    context "when password not equal password confirmation" do
      before do 
        user.password = "password"
        user.password_confirmation = "confirmation"
      end
      it { should_not be_valid }
    end

    context "when password is to short" do
      before { user.password = "a"*5 }
      it { should_not be_valid }
    end    
  end
end
