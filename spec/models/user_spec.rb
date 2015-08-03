require 'rails_helper'

RSpec.describe User, type: :model do

context "Create different users" do

  it "creates a valid user role from the Factory" do
    expect(FactoryGirl.build(:user)).to be_valid
    expect(FactoryGirl.build(:user)).to be_user
  end

  it "creates a valid admin role from the Factory" do
    expect(FactoryGirl.build(:user, :admin)).to be_valid
    expect(FactoryGirl.build(:user, :admin)).to be_admin
  end

end

end
