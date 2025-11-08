# app/models/member.rb
class Member < ApplicationRecord
  belongs_to :user
  belongs_to :list

  validates :user_id, uniqueness: { scope: :list_id, message: "já é membro desta lista" }

  # ✅ Corrige o uso do enum no Rails 8
  attribute :status, :integer, default: 1  # accepted por padrão
  enum :status, { pending: 0, accepted: 1, rejected: 2 }

  private

  def set_default_status
    self.status ||= :accepted
  end
end
