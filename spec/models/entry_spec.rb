require 'rails_helper'

RSpec.describe Entry, type: :model do
  it "creates a valid note entry" do
    expect(FactoryGirl.build(:entry)).to be_valid
  end
end
