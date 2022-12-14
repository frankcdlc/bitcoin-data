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

ActiveRecord::Schema[7.0].define(version: 2022_08_30_172345) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocks", force: :cascade do |t|
    t.string "hash_block"
    t.string "prev_block"
    t.integer "block_index"
    t.integer "time"
    t.integer "bits"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_index"], name: "index_blocks_on_block_index", unique: true
    t.index ["hash_block"], name: "index_blocks_on_hash_block", unique: true
    t.index ["prev_block"], name: "index_blocks_on_prev_block", unique: true
  end

end
