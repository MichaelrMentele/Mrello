class User < ApplicationRecord
  validates_presence_of :fullname, :email
  validates_uniqueness_of :email

  has_many :memberships
  has_many :organizations, through: :memberships

  has_many :ownerships, as: :owner

  has_many :boards, through: :ownerships

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