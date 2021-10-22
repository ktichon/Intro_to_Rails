class DungeonPurpose < ApplicationRecord
  has_many :chamber_purposes, :dungeon_purposes
  vaildates :purpose, presence:true, uniqueness: true
end
