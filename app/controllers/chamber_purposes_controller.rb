class ChamberPurposesController < ApplicationController
  def index
    @chamber_purposes = ChamberPurpose.includes(:dungeon_purpose).all.offset(1)
  end

  def show
    @chamber_purpose = ChamberPurpose.find(params[:id])
  end
end
