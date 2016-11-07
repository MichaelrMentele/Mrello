class User < ApplicationRecord
  validates_presence_of :fullname
  has_many :lists
end