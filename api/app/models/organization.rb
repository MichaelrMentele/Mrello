class Organization < ApplicationRecord
  belongs_to :admin, class_name: "User", foreign_key: :admin_id
  has_many :users
end