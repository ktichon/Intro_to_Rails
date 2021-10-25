# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_25_215546) do

  create_table "adventure_in_dungeons", force: :cascade do |t|
    t.integer "adventure_id", null: false
    t.integer "dungeon_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "goal"
    t.index ["adventure_id"], name: "index_adventure_in_dungeons_on_adventure_id"
    t.index ["dungeon_id"], name: "index_adventure_in_dungeons_on_dungeon_id"
  end

  create_table "adventures", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "chamber_purposes", force: :cascade do |t|
    t.string "purpose"
    t.integer "dice_odds"
    t.integer "dungeon_purpose_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dungeon_purpose_id"], name: "index_chamber_purposes_on_dungeon_purpose_id"
  end

  create_table "dungeon_purposes", force: :cascade do |t|
    t.string "purpose"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dungeons", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "key_event"
    t.integer "width"
    t.integer "depth"
    t.integer "chambers"
    t.integer "dungeon_purpose_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "num_rooms"
    t.index ["dungeon_purpose_id"], name: "index_dungeons_on_dungeon_purpose_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "room_type"
    t.integer "x1"
    t.integer "x2"
    t.integer "y1"
    t.integer "y2"
    t.integer "dungeon_id", null: false
    t.integer "chamber_purpose_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "num"
    t.index ["chamber_purpose_id"], name: "index_rooms_on_chamber_purpose_id"
    t.index ["dungeon_id"], name: "index_rooms_on_dungeon_id"
  end

  add_foreign_key "adventure_in_dungeons", "adventures"
  add_foreign_key "adventure_in_dungeons", "dungeons"
  add_foreign_key "chamber_purposes", "dungeon_purposes"
  add_foreign_key "dungeons", "dungeon_purposes"
  add_foreign_key "rooms", "chamber_purposes"
  add_foreign_key "rooms", "dungeons"
end
