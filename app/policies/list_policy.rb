class ListPolicy < ApplicationPolicy
  attr_reader :user, :list

  def initialize(user, list)
    @user = user
    @list = list
  end

  def show?
    owner? || member?
  end

  def update?
    owner? || member?
  end

  def destroy?
    owner?
  end

  def create?
    true
  end

  def index?
    true
  end

  def show?
    owner? || member?
  end

  private

  def owner?
    list.owner == user
  end

  def member?
    list.members.exists?(user_id: user.id)
  end
end
