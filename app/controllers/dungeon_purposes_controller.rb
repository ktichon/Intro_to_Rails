class DungeonPurposesController < ApplicationController
  def index
    @dungeon_purposes = DungeonPurpose.includes(:chamber_purpose).all.order("purpose DESC").offset(1)
  end

  def show
    @dungeon_purpose = DungeonPurpose.find(params[:id])
  end
end
