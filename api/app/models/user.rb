class User < ApplicationRecord
  validates_presence_of :fullname, :email
  validates_uniqueness_of :email

  has_one :board
  has_many :shared_boards, class_name: "Relationship", foreign_key: :followable_id, as: :followable

  belongs_to :organization, optional: true
  has_many :join_requests

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