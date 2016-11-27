class Organization < ApplicationRecord
  validates_presence_of :title

  has_many :memberships
  has_many :users, through: :memberships

  has_many :ownerships, as: :owner

  has_many :boards, through: :ownerships
  has_many :lists, through: :boards
  has_many :cards, through: :lists
end