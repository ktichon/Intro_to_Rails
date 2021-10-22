class DungeonPurpose < ApplicationRecord
  has_many :chamber_purposes
  has_many :dungeons
  validates  :purpose, presence:true, uniqueness: true
end
