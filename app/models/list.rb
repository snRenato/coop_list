class List < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :members, dependent: :destroy
  has_many :users, through: :members
  has_many :items, dependent: :destroy
  validates :title, presence: true

  private

  def add_owner_as_member
    members.create!(user: owner, status: 1)
  end
end
