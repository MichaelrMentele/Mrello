class JoinRequest < ApplicationRecord
  validates_presence_of :user_id, :organization_id
  belongs_to :user
  belongs_to :organization
end