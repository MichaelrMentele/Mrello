class User < ApplicationRecord
  validates_presence_of :fullname, :email
  validates_uniqueness_of :email

  has_many :memberships
  has_many :organizations, through: :memberships

  has_many :boards, as: :owner
  has_many :lists, through: :boards
  has_many :cards, through: :lists

  has_secure_password
end