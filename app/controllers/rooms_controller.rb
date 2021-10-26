class RoomsController < ApplicationController
  def index
    @rooms = Room.includes(:dungeon).includes(:chamber_purpose).order(:dungeon).page(params[:page])
  end

  def show
    @room = Room.find(params[:id])
  end
end
