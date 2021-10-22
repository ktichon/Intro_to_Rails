# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"
require_relative 'GenerateDungeons'

Room.delete_all
Dungeon.delete_all
ChamberPurpose.delete_all
DungeonPurpose.delete_all

max_width = 100
max_rooms = 100
max_chambers = 10
sizing = 3

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

puts "Chamber Purposes Complete"
csv_data = File.read(Rails.root.join("db/DungeonLocation.csv"))
location_list = CSV.parse(csv_data, headers: true, encoding: "utf-8")
csv_data = File.read(Rails.root.join("db/DungeonHistory.csv"))
history_list = CSV.parse(csv_data, headers: true, encoding: "utf-8")

for i in 0..3 do
  name = "Dungeon of the #{Faker::Games::DnD.background} #{Faker::Games::DnD.monster}"
  new_dungeon_details = create_dungeon(max_width, max_rooms, max_chambers, sizing )
  dungeon_purpose = DungeonPurpose.find(DungeonPurpose.ids.sample)


  dungeon_purpose.dungeons.create(
    name: name,
    location: location_list[rand(location_list.count)]["location"],
    key_event: history_list[rand(history_list.count)]["key_event"],
    width: new_dungeon_details[:max_x],
    depth: new_dungeon_details[:max_y],
    chambers: new_dungeon_details[:num_chambers]
  )
end



puts "Created #{DungeonPurpose.count} Dungeon Purposes"
puts "Created #{ChamberPurpose.count} Chamber Purposes"
puts "Created #{Dungeon.count} Dungeons"




