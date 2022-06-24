require 'rails_helper'

RSpec.describe Comment, type: :model do
  subject { build(:comment) }

  it "is valid" do
    is_expected.to be_valid
  end
end