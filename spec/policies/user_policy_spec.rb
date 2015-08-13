require 'rails_helper'
require 'pry'

describe UserPolicy do
  subject { described_class }

  permissions :create?, :new?, :destroy? do

    it "grants access for admin" do
      admin = build(:user, :admin)
      expect(subject).to permit(admin, build(:user))
    end

    it "denies access for users" do
      expect(subject).not_to permit(build(:user), build(:user))
    end

    it "denies access for guests" do
      expect(subject).not_to permit(User.guest.new, build(:user))
    end
  end

  permissions :update?, :edit? do
    it "denies access for guests" do
      expect(subject).not_to permit(User.guest.new, build(:user))
    end

    it "grants access for user" do
      user = build(:user)
      expect(subject).to permit(user, user)
    end

    it "grants access for admin" do
      admin = build(:user, :admin)
      expect(subject).to permit(admin, build(:user))
    end

    it "denies access for user to change role" do
      user = create(:user)
      updated_user = User.find(user.id)
      updated_user.role = 'admin'
      expect(user.id).to eq(updated_user.id)
      expect(subject).not_to permit(user, updated_user)
    end

  end
end
