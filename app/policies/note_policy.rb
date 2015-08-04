class NotePolicy < ApplicationPolicy
  attr_reader :user, :note

  def initialize(user, note)
    @user = user
    @note = note
  end

  def create?
    @user.user? or user.admin?
  end

  def new?
    create?
  end

  def update?
    @user == @note.user or @user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

end
