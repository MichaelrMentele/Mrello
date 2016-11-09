class Comment < ApplicationRecord
  validates_presence_of :payload
  belongs_to :card
end