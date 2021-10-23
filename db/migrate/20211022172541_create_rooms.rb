class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.string :room_type
      t.integer :x1
      t.integer :x2
      t.integer :y1
      t.integer :y2
      t.references :dungeon, null: false, foreign_key: true
      t.references :chamber_purpose, null: false, foreign_key: true

      t.timestamps
    end
  end
end
