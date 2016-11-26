class Board < ApplicationRecord
  validates_presence_of :ownership_id

  has_many :lists

  belongs_to :ownership
end