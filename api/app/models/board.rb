class Board < ApplicationRecord
  validates_presence_of :owner_id, :owner_type

  has_many :lists

  belongs_to :owner, polymorphic: true
end