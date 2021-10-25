class DungeonPurposesController < ApplicationController
  def index
    @dungeon_purposes = DungeonPurpose.all
  end

  def show
    @dungeon_purpose = DungeonPurpose.find(params[:id])
  end
end
