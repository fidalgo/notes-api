require 'rails_helper'

describe EntryPolicy do

  subject {described_class}

  permissions :create?, :new? do

    it "grants access for admin" do
      admin = create(:user, :admin)
      expect(subject).to permit(admin, build(:entry))
    end

    it "grants access for users" do
      entry = build(:entry)
      expect(subject).to permit(entry.note.user, entry)
    end

    it "denies access for guests" do
      expect(subject).not_to permit(User.guest.new, build(:entry))
    end
  end

  permissions :update?, :edit?, :destroy? do
    it "denies access for guests" do
      expect(subject).not_to permit(User.guest.new, build(:entry))
    end

    it "grants access for user" do
      entry = build(:entry)
      expect(subject).to permit(entry.note.user, entry)
    end

    it "grants access for admin" do
      admin = create(:user, :admin)
      expect(subject).to permit(admin, build(:entry))
    end
  end


end
