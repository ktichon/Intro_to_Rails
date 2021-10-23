class AddRoomsToDungeons < ActiveRecord::Migration[6.1]
  def change
    add_column :dungeons, :num_rooms, :integer
  end
end
