class RoomsController < ApplicationController
  def index
    @rooms = Room.includes(:dungeon).includes(:chamber_purpose).all
  end

  def show
    @room = Room.find(params[:id])
  end
end
