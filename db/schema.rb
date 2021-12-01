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

ActiveRecord::Schema.define(version: 2021_12_01_173518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.bigint "word_id", null: false
    t.integer "stepCount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["word_id"], name: "index_games_on_word_id"
  end

  create_table "revealed_indices", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.integer "index"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_revealed_indices_on_game_id"
  end

  create_table "steps", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.string "stepWord"
    t.integer "inPlaceLetterCount"
    t.integer "existLetterCount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_steps_on_game_id"
  end

  create_table "words", force: :cascade do |t|
    t.string "word"
    t.integer "letterCount", default: 0
    t.integer "sessionCount", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "definition"
    t.string "ktiv_male"
  end

  add_foreign_key "games", "words"
  add_foreign_key "revealed_indices", "games"
  add_foreign_key "steps", "games"
end
