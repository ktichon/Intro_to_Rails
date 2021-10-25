class ChamberPurposesController < ApplicationController
  def index
    @chamber_purposes = ChamberPurpose.includes(:dungeon_purpose).all
  end

  def show
    @chamber_purpose = ChamberPurpose.find(params[:id])
  end
end
