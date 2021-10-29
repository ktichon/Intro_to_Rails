class DungeonPurpose < ApplicationRecord
  has_many :chamber_purposes
  has_many :dungeons
  validates  :purpose, presence:true, uniqueness: true
  validates  :total_roll, presence:true, numericality: { only_integer: true }
end
