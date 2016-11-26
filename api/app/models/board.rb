class Board < ApplicationRecord
  validates_presence_of :admin_id

  has_many :lists
  belongs_to :admin, class_name: "User", foreign_key: :admin_id
end