class Room < ApplicationRecord
  belongs_to :dungeon
  belongs_to :chamber_purpose
  validates  :dungeon, presence: true
  validates  :x1, :x2, :y1, :y2, presence: true, numericality: { only_integer: true }
end
