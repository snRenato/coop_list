class Member < ApplicationRecord
  belongs_to :user
  belongs_to :list


  # enum status: { pending: 0, accepted: 1 }

  validates :user_id, uniqueness: { scope: :list_id, message: "já é membro desta lista" }


  def can_add_members?
    accepted?
  end

  def can_remove_members?(current_user)
    list.owner == current_user
  end

  def can_manage_items?
    accepted?
  end

  private

  def set_default_status
    return unless list && user
    self.status ||= (user_id == list.owner_id ? :accepted : :pending)
  end
end
