class User < ApplicationRecord
  validates_presence_of :fullname, :email
  validates_uniqueness_of :email

  has_many :lists
  belongs_to :organization, optional: true
  has_many :join_requests

  has_secure_password

  def admin?
    self.admin
  end
end