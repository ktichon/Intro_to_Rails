class Room < ApplicationRecord
  belongs_to :dungeon
  belongs_to :chamber_purpose, optional: true
  has_many :room_furnitures
  has_many :furnitures, through: :room_furnitures
  validates  :dungeon, presence: true
  validates  :x1, :x2, :y1, :y2, presence: true, numericality: { only_integer: true }
  paginates_per 50
end
