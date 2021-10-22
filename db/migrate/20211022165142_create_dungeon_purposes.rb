class CreateDungeonPurposes < ActiveRecord::Migration[6.1]
  def change
    create_table :dungeon_purposes do |t|
      t.string :purpose

      t.timestamps
    end
  end
end
