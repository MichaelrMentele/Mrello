class Organization < ApplicationRecord
  validates_presence_of :title

  has_many :memberships
  # TODO: instead of users, use memberships--its more descriptive
  has_many :users, through: :memberships

  has_many :boards, as: :owner
  has_many :lists, through: :boards
  has_many :cards, through: :lists

  def member?(user)
    self.users.exists?(user.id)
  end
end