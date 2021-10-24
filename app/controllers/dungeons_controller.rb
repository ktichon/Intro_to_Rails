class DungeonsController < ApplicationController
  def index
    @dungeons = Dungeon.includes(:dungeon_purpose).all.order("name ASC")
  end

  def show
    @dungeon = Dungeon.find(params[:id])
  end
end
