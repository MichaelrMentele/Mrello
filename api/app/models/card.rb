class Card < ApplicationRecord
  validates_presence_of :title

  belongs_to :list
  has_many :comments
end