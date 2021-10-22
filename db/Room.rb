class NewRoom
  def initialize(from_exit, widthFactor, fitDoorsNice, type)
     @direction = from_exit[:direction]
     from_points = from_exit[:from_points]
     @type = type
     @length =  widthFactor
     @width = 1
     @adjustment = 0
     if(type == 'p' || (from_exit[:from].include? 's'))
      @adjustment = fitDoorsNice
     end
     if(type == 'c')
      @width = widthFactor
     end
     if(type == 's')
      @width = widthFactor + 2
      @length += 2
     end

    #  if (type == 's')
    #   @width = widthFactor + 1
    #   @length += 1
    #  end
    case @direction
    when 0
      @x1 = from_points[:x1] + @adjustment
      @y1 = from_points[:y1] + @length
      @x2 = from_points[:x1] + @width + @adjustment
      @y2 = from_points[:y1]
    when 1
      @x1 = from_points[:x2]
      @y1 = from_points[:y1] + @adjustment
      @x2 = from_points[:x2] + @length
      @y2 = from_points[:y2] + @width + @adjustment
    when 2
      @x1 = from_points[:x2] - @width - @adjustment
      @y1 = from_points[:y2]
      @x2 = from_points[:x2] - @adjustment
      @y2 = from_points[:y2] + @length
    when 3
      @x1 = from_points[:x1] - @length
      @y1 = from_points[:y2] - @width - @adjustment
      @x2 = from_points[:x1]
      @y2 = from_points[:y2] - @adjustment

    else
      puts "Room:Error, direction not valid"
    end
  end

  def getDirection()
    return @direction
  end

  def getPoints()
    return {:x1 => @x1, :y1 => @y1, :x2 => @x2, :y2 => @y2}
  end
  def resizeX(resize)
    @x1 -= resize
    @x2 -= resize
  end

  def getType()
    return @type
  end

  def getExits(id)
    num_exit_odds = [1,1,1,2,2,3]
    if (getType == 'c')
      num_exit_odds = [1,1,1,2,2,2,3,3,3]
    end
    if(getType == 's')
      num_exit_odds = [2,3,3]
    end
    num_exits = num_exit_odds.sample
    available_exits = [-1, 0, 1]
    exits = []
    for i in 0...num_exits
      random_direction = available_exits.sample
      available_exits.delete(random_direction)
      exits.push({:from_points => getPoints, :direction => checkDirection(random_direction + getDirection()), :from => "#{getType}#{id}" })
    end
    return exits

  end
  def checkDirection(dir)
    if (dir <= -1)
      dir = 3
    elsif(dir >= 4)
      dir = 0
    end
    return dir
  end

end

