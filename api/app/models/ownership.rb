class Ownership < ApplicationRecord
  validates_presence_of(:owner_type)
  validates_presence_of(:owner_id)

  belongs_to :owner, polymorphic: true
  has_many :boards
end