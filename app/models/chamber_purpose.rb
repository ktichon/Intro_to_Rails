class ChamberPurpose < ApplicationRecord
  belongs_to :dungeon_purpose
  has_many :rooms
  validates  :dungeon_purpose, :purpose, presence: true
  validates  :max_roll, :min_roll, presence: true, numericality: { only_integer: true }
  paginates_per 50
end
