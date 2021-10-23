class DungeonsController < ApplicationController
  def index
    @dungeons = Dungeon.includes(:dungeon_purpose).all.order("name ASC")
  end

  def show
    @dungeon = Dungeon.includes()
  end
end
