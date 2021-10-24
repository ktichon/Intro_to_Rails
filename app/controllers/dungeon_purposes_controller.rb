class DungeonPurposesController < ApplicationController
  def index
    @dungeon_purposes = DungeonPurpose.all.offset(1)
  end

  def show
    @dungeon_purpose = DungeonPurpose.find(params[:id])
  end
end
