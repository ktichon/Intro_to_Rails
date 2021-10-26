class DungeonsController < ApplicationController
  def index
    @dungeons = Dungeon.includes(:dungeon_purpose).all.order("name ASC")
    dungeonTypes = DungeonPurpose.pluck(:purpose)
    @dungeonTypes = dungeonTypes.insert(0,'None')
  end

  def show
    @dungeon = Dungeon.find(params[:id])

  end

  def search
    dungeonTypes = DungeonPurpose.pluck(:purpose)
    @dungeonTypes = dungeonTypes.insert(0,'None')
    wildcard_search = "%#{params[:keywords]}%"
    id = '%'
    if params[:type] != "None"
      dungeon_purpose = DungeonPurpose.find_by("purpose LIKE ? ", "%#{params[:type]}%" )
      id = "%#{dungeon_purpose.id}%"
    end
    @dungeons = Dungeon.where("dungeon_purpose_id LIKE? ", id).where("name LIKE? ", wildcard_search)
  end
end
