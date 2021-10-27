# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"
require_relative 'GenerateDungeons'

def getDir(direction)
  case direction
  when 1
    return 'right'
  when 2
    return 'down'
  when 3
    return 'left'
  else
    return 'up'
  end
end



AdventureInDungeon.delete_all
Adventure.delete_all
Room.delete_all
Dungeon.delete_all
ChamberPurpose.delete_all
DungeonPurpose.delete_all

@max_width = 30
@max_rooms = 100
@max_chambers = 10
@sizing = 3

file_name = Rails.root.join("db/Chamber_Purpose.csv")
puts "Loading Chamber Purposes from CSV file: #{file_name}"
csv_data = File.read(file_name)
chamber_purposes_list = CSV.parse(csv_data, headers: true, encoding: "utf-8")

chamber_purposes_list.each do |c_pur|
  dungeon_purpose = DungeonPurpose.find_or_create_by(purpose: c_pur["d_purpose"])

  if dungeon_purpose && dungeon_purpose.valid?
    chamber_purpose = dungeon_purpose.chamber_purposes.create(
      purpose: c_pur["chamber_purpose"],
      dice_odds: c_pur["dice_odds"]
    )
  end
end

adventures = []
for i in 0..10 do

  a_name = "The #{Faker::Science.modifier } #{Faker::Verb.base.capitalize} of #{Faker::Name.name} #{Faker::Superhero.suffix}"
  a_description = Faker::Books::Lovecraft.paragraph
  adventures.push([a_name, a_description])
end

puts "Chamber Purposes Complete"
puts "Creating Dungeons ...."
csv_data = File.read(Rails.root.join("db/DungeonLocation.csv"))
location_list = CSV.parse(csv_data, headers: true, encoding: "utf-8")
csv_data = File.read(Rails.root.join("db/DungeonHistory.csv"))
history_list = CSV.parse(csv_data, headers: true, encoding: "utf-8")
csv_data = File.read(Rails.root.join("db/AdventureGoals.csv"))
goals_list = CSV.parse(csv_data, headers: true, encoding: "utf-8")

d_purpose_ids = DungeonPurpose.pluck(:id)

def addDungeonToDataBase(dungeon_purpose_id, location_list, history_list, adventures_list, goals_list)
  name = "Dungeon of the #{Faker::Emotion.adjective.capitalize} #{Faker::Games::DnD.background} #{Faker::Games::DnD.monster}"
  new_dungeon_details = create_dungeon(@max_width, @max_rooms, @max_chambers, @sizing )
  dungeon_purpose = DungeonPurpose.find(dungeon_purpose_id)


   new_dungeon = dungeon_purpose.dungeons.create(
    name: name,
    location: location_list[rand(location_list.count)]["location"],
    key_event: history_list[rand(history_list.count)]["key_event"],
    width: new_dungeon_details[:max_x],
    depth: new_dungeon_details[:max_y],
    chambers: new_dungeon_details[:num_chambers],
    num_rooms: new_dungeon_details[:num_rooms]
  )





  if new_dungeon && new_dungeon.valid?

    for i in 0..1 do
      adventureArray = adventures_list.sample
      adventure = Adventure.find_or_create_by(name: adventureArray[0], description: adventureArray[1])
      AdventureInDungeon.create(adventure: adventure, dungeon: new_dungeon, goal: goals_list[rand(goals_list.count)])
    end

    dungeon_rooms = new_dungeon_details[:all_rooms]
    max_roll = dungeon_purpose.chamber_purposes.count;
    roll_purpose = dungeon_purpose.chamber_purposes.order(:dice_odds)
    room_number = 1;

    dungeon_rooms.each do |new_room|

      room_purpose = nil

      if new_room.getType != 'p'

        dice_roll = rand(max_roll) + 1

        roll_purpose.each do |rolled_pur|

          if rolled_pur["dice_odds"] >= dice_roll
            room_purpose = rolled_pur
            break
          end
        end
      end
      new_dungeon.rooms.create(
        room_type: new_room.getType,
        x1: new_room.getPoints[:x1],
        x2: new_room.getPoints[:x2],
        y1: new_room.getPoints[:y1],
        y2: new_room.getPoints[:y2],
        num: room_number,
        width: new_room.getWidth,
        length: new_room.getLength,
        direction: getDir(new_room.getDirection()),
        chamber_purpose: room_purpose
      )
      room_number += 1
    end


    puts "Created #{new_dungeon_details[:num_rooms]} rooms for #{name}. Reason for ending #{new_dungeon_details[:end_reason]} "
  end
end


d_purpose_ids.each do |d_id|
  addDungeonToDataBase(d_id, location_list, history_list, adventures, goals_list)
  #addDungeonToDataBase(d_purpose_ids.sample, location_list, history_list, adventures, goals_list)
end


puts "Created #{Adventure.count} Adventures"
puts "Created #{DungeonPurpose.count} Dungeon Purposes"
puts "Created #{ChamberPurpose.count} Chamber Purposes"
puts "Created #{Dungeon.count} Dungeons"
puts "Created #{Room.count} Rooms"




