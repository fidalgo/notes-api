class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :user

  def initialize(current_user, user)
    @current_user = current_user
    @user = user
  end

  def create?
      @current_user.admin?
  end

  def new?
    create?
  end

  def update?
    @current_user == @user or @current_user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    create?
  end

end
