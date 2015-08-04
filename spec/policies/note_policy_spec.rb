require 'rails_helper'

describe NotePolicy do
  subject { described_class }

  permissions :create?, :new? do

    it "grants access for admin" do
      admin = create(:user, :admin)
      expect(subject).to permit(admin, build(:note))
    end

    it "grants access for users" do
      note = build(:note)
      expect(subject).to permit(note.user, note)
    end

    it "denies access for guests" do
      expect(subject).not_to permit(User.guest.new, build(:note))
    end
  end

  permissions :update?, :edit?, :destroy? do
    it "denies access for guests" do
      expect(subject).not_to permit(User.guest.new, build(:note))
    end

    it "grants access for user" do
      note = build(:note)
      expect(subject).to permit(note.user, note)
    end

    it "grants access for admin" do
      admin = create(:user, :admin)
      expect(subject).to permit(admin, build(:note))
    end
  end

end
