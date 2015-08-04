class EntryPolicy < ApplicationPolicy

  attr_reader :user, :entry

  def initialize(user, entry)
    @user = user
    @entry = entry
  end

  def create?
    @user.user? or @user.admin?
  end

  def new?
    create?
  end

  def update?
    @user == @entry.note.user or @user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

end
