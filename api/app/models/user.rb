class User < ApplicationRecord
  validates_presence_of :fullname, :email
  validates_uniqueness_of :email

  has_many :boards, foreign_key: :owner_id
  has_many :join_requests

  belongs_to :organization, optional: true

  has_secure_password

  def admin?
    self.admin
  end

  def not_admin?
    !self.admin?
  end

  def has_organization?
    self.organization
  end

  def no_organization?
    !self.has_organization?
  end
end