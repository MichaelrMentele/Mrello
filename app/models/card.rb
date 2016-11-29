class Card < ApplicationRecord
  validates_presence_of :title, :list_id

  belongs_to :list

  has_many :comments
end