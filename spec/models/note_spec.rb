require 'rails_helper'

RSpec.describe Note, type: :model do
  it "creates a valid user note" do
    expect(FactoryGirl.build(:note)).to be_valid
  end
end
