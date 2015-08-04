require 'rails_helper'

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
  end
end
