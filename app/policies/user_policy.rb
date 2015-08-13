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
    if @current_user.admin?
      return true
    elsif @current_user.id == @user.id
      return @current_user.role == @user.role
    else
      return false
    end
  end

  def edit?
    update?
  end

  def destroy?
    create?
  end

end
