class ChamberPurposesController < ApplicationController
  def index
    @chamber_purposes = ChamberPurpose.includes(:dungeon_purpose).all
  end

  def show
    @chamber_purpose = ChamberPurpose.find(params[:id])

    last_roll = 1

    @chamber_purpose.dungeon_purpose.chamber_purposes.each do |c_purpose|
      if @chamber_purpose == c_purpose
        break
      end
      last_roll = c_purpose.dice_odds + 1
    end

    @chamber_roll = @chamber_purpose.dice_odds.to_s;
    if last_roll != @chamber_purpose.dice_odds
      @chamber_roll = "#{last_roll}-#{@chamber_purpose.dice_odds}"
    end
    top_roll = @chamber_purpose.dungeon_purpose.chamber_purposes.order("dice_odds ASC").last.dice_odds

    @chamber_odds = ((@chamber_purpose.dice_odds - last_roll + 1)/ top_roll.to_f * 100).round(2)
  end
end
