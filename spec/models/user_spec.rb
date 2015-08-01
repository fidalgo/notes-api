require 'rails_helper'

RSpec.describe User, type: :model do

context "Create a valid user" do
  it "creates a valid user from the Factory" do
    expect(FactoryGirl.build(:user)).to be_valid
  end
end

end
