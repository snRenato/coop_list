class List < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :owner, class_name: "User"
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :items, dependent: :destroy
  validates :title, presence: true

  private

  def add_owner_as_member
    members.create!(user: owner, status: 1)
  end

  # Regera o slug se o título mudar
  def should_generate_new_friendly_id?
    slug.blank? || will_save_change_to_title?
  end
end
