class List < ApplicationRecord
  belongs_to :user
  has_many :cards

  validates_presence_of :title
end