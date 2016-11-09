class User < ApplicationRecord
  validates_presence_of :fullname, :email, :password 
  validates_uniqueness_of :email
  has_many :lists

  has_secure_password
end