class ListPolicy < ApplicationPolicy
  attr_reader :user, :list

  def initialize(user, list)
    @user = user
    @list = list
  end

  def index?
    true
  end

  def show?
  user.present? && (owner? || member?)
  end

  def create?
    user.present?
  end

  def update?
    user.present? && (owner? || member?)
  end

  def destroy?
    user.present? && owner?
  end

  private

  def owner?
    list.owner == user
  end

  def member?
    list.members.exists?(user_id: user.id)
  end

class Scope < Scope
  def resolve
    return scope.none unless user
    scope.joins("LEFT JOIN members ON members.list_id = lists.id")
         .where("lists.owner_id = ? OR members.user_id = ?", user.id, user.id)
         .distinct
  end
end
end
