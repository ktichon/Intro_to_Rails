class ChamberPurposesController < ApplicationController
  def index
    @chamber_purposes = ChamberPurpose.includes(:dungeon_purpose).order(:dungeon_purpose).page(params[:page])
  end

  def show
    @chamber_purpose = ChamberPurpose.find(params[:id])

    @chamber_roll = @chamber_purpose.max_roll.to_s;
    if @chamber_purpose.min_roll != @chamber_purpose.max_roll
      @chamber_roll = "#{ @chamber_purpose.min_roll}-#{@chamber_purpose.max_roll}"
    end
  end
end
