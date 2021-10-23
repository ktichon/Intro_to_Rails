class CreateDungeons < ActiveRecord::Migration[6.1]
  def change
    create_table :dungeons do |t|
      t.string :name
      t.string :location
      t.string :key_event
      t.integer :width
      t.integer :depth
      t.integer :chambers
      t.references :dungeon_purpose, null: false, foreign_key: true

      t.timestamps
    end
  end
end
