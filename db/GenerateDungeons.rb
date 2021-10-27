require_relative 'Room'

def validate_Room(room_points, rooms_to_check, maxWidth)
  if(rooms_to_check.empty?)
    return true
  end

  if(room_points[:x1] <= 0 || room_points[:x2] >= maxWidth || room_points[:y1] < 0|| room_points[:y2] < 0 )
    return false
  end
  rooms_to_check.each do |checkRoom|
    if(!(room_points[:x1] >= checkRoom.getPoints()[:x2] || room_points[:x2] <= checkRoom.getPoints()[:x1] ||
      room_points[:y1] >= checkRoom.getPoints()[:y2] || room_points[:y2]  <= checkRoom.getPoints()[:y1]))
      return false
    end
  end
  return true
end

def printMap(dungeonStats)
  maxDepth = dungeonStats[:max_y] + 1
  maxlong = dungeonStats[:max_x] + 2
  dungeon = dungeonStats[:all_rooms]

  for row in 0..maxDepth
    rowline = ""
    for column in 0..maxlong
      collumnValue = "#"

      dungeon.each do |checkRoom|
        if(column >= checkRoom.getPoints()[:x1] && column <= checkRoom.getPoints()[:x2] &&
          row >= checkRoom.getPoints()[:y1] && row <= checkRoom.getPoints()[:y2])
          if (collumnValue == '#' || collumnValue == 'p')
            collumnValue = checkRoom.getType()
          end
        end
     end
      rowline += collumnValue
    end
    puts(rowline)
  end
  puts "Deepist part of the dungeon: #{maxDepth}"
  puts "Widest  part of the dungeon: #{maxlong}"
  puts "Number of rooms: #{dungeonStats[:num_rooms]}"
  puts "Number of chambers: #{dungeonStats[:num_chambers]}"
  puts "Dungeon end condition: #{dungeonStats[:end_reason]}"

end

def create_dungeon(maxWidth, maxRooms, maxChambers, realtive_sizing )
  midPoint = maxWidth.div(2)
  adjust = realtive_sizing.div(2)
  start_Points = {:x1 => midPoint, :y1 => 0, :x2 => midPoint + realtive_sizing, :y2 => 0}
  exit_zero = {:from_points => start_Points, :direction => 2, :from => "s0" }

  startingRoom = NewRoom.new(exit_zero, realtive_sizing, adjust, 's')

  valid_rooms = [startingRoom]
  exits = startingRoom.getExits(valid_rooms.length)
  numChambers = 0
  while numChambers != maxChambers
    if(valid_rooms.length == maxRooms || numChambers == maxChambers )
      break
    end

    currentExit = exits.shift().clone
    roomTypes = ['p','p', 'c']
    if(!(currentExit[:from].include? 'p'))
      roomTypes = ['p']
    end


    new_room_type = roomTypes.sample


    new_room = NewRoom.new(currentExit, realtive_sizing, adjust, new_room_type)

    if(validate_Room(new_room.getPoints(), valid_rooms, maxWidth))
      valid_rooms.push(new_room)
      exits.push(*new_room.getExits(valid_rooms.length))
      if(new_room_type == 'c')
        numChambers += 1
      end
    end

    if exits.empty?
      deepest_room = startingRoom
      valid_rooms.each do |getLowestRoom|
        if (getLowestRoom.getPoints()[:y2] > deepest_room.getPoints()[:y2])
          deepest_room = getLowestRoom;
        end
      end
      exits.push(*deepest_room.getExits(valid_rooms.length))
    end
  end


  min_x = maxWidth
  max_x = 0
  max_y =0
  valid_rooms.each do |findRoomStats|
    if(findRoomStats.getPoints()[:x1] < min_x)
      min_x = findRoomStats.getPoints()[:x1]
    end
    if(findRoomStats.getPoints()[:x2] > max_x)
      max_x = findRoomStats.getPoints()[:x2]
    end
    if(findRoomStats.getPoints()[:y2] > max_y)
      max_y = findRoomStats.getPoints()[:y2]
    end

  end
  valid_rooms.each do |resizeRoom|
    resizeRoom.resizeX(min_x -1)
  end
  max_x -= min_x

  dungeon_end_reason = "Dungeon finished because "
  if(exits.empty?)
    dungeon_end_reason += "there where no more available exits"
  elsif(valid_rooms.length == maxRooms)
    dungeon_end_reason += "it reached the max number of rooms"
  elsif(numChambers == maxChambers)
    dungeon_end_reason += "it reached the max number of chambers"
  else
    dungeon_end_reason += "of an unkown reason"
  end

  return { :all_rooms => valid_rooms, :end_reason => dungeon_end_reason, :num_chambers => numChambers, :num_rooms => valid_rooms.length,
  :min_x => min_x, :max_x => max_x , :max_y => max_y}
end




