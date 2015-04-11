require 'rails_helper'

describe "Pack" do

  let(:pack) { create(:pack) }
  subject { pack }

  context "validating" do
    context "when title is no present" do
      before { pack.title = "" }
      it { should_not be_valid }
    end

    context "when user is not present" do
      before { pack.user = nil }
      it { should_not be_valid }
    end
  end
end
