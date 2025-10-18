class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :member, optional: true

  scope :unread, -> { where(read: false) }

  def invite?
    action == "invite"
  end

  after_create_commit -> {
    broadcast_append_to "notifications_#{user.id}",
      target: "notifications-dropdown",
      partial: "notifications/notification",
      locals: { notification: self }
  }
end
