class List < ApplicationRecord
  validates_presence_of :title, :board_id

  belongs_to :board

  has_many :cards

  validates_presence_of :title
end