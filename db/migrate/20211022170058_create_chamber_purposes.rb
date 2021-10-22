class CreateChamberPurposes < ActiveRecord::Migration[6.1]
  def change
    create_table :chamber_purposes do |t|
      t.string :purpose
      t.integer :dice_odds
      t.references :dungeon_purpose, null: false, foreign_key: true

      t.timestamps
    end
  end
end
