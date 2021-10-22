class ChamberPurpose < ApplicationRecord
  belongs_to :dungeon_purpose
  has_many :rooms
  vaildates :dungeon_purpose, :purpose, :dice_odds, presence: true
  vaildates :dice_odds, numericality: { only_integer: true }
end
