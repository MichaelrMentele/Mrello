class Board < ApplicationRecord
  validates_presence_of :owner_id

  has_many :lists

  belongs_to :owner, class_name: "User", foreign_key: :owner_id
end