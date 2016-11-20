class User < ApplicationRecord
  validates_presence_of :fullname, :email, :password 
  validates_uniqueness_of :email

  has_many :lists
  belongs_to :organization, optional: true

  has_secure_password

  def admin?
    self.admin
  end
end