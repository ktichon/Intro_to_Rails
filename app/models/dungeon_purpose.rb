class DungeonPurpose < ApplicationRecord
  vaildates :purpose, presence:true, uniqueness: true
end
