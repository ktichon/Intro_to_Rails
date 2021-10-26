class ChamberPurpose < ApplicationRecord
  belongs_to :dungeon_purpose
  has_many :rooms
  validates  :dungeon_purpose, :purpose, :dice_odds, presence: true
  validates  :dice_odds, numericality: { only_integer: true }
  paginates_per 50
end
