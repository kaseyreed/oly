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

ActiveRecord::Schema[7.0].define(version: 2022_02_19_231454) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "email_webhook_requests", force: :cascade do |t|
    t.json "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movements", force: :cascade do |t|
    t.text "name"
    t.text "movement_type"
    t.boolean "complex"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_movements_on_name", unique: true
  end

  create_table "raw_training_items", force: :cascade do |t|
    t.integer "raw_training_id", null: false
    t.text "name"
    t.text "description"
    t.boolean "superset"
    t.boolean "processed"
    t.integer "index"
    t.text "results"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["raw_training_id"], name: "index_raw_training_items_on_raw_training_id"
  end

  create_table "raw_trainings", force: :cascade do |t|
    t.text "date"
    t.text "name"
    t.text "warmup"
    t.text "cooldown"
    t.boolean "processed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "training_items", force: :cascade do |t|
    t.integer "training_id", null: false
    t.integer "index"
    t.boolean "complex"
    t.integer "num_sets"
    t.integer "rep_scheme"
    t.integer "state"
    t.text "notes"
    t.boolean "superset"
    t.integer "raw_training_items_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["raw_training_items_id"], name: "index_training_items_on_raw_training_items_id"
    t.index ["training_id"], name: "index_training_items_on_training_id"
  end

  create_table "training_items_movements", force: :cascade do |t|
    t.integer "training_item_id", null: false
    t.integer "movement_id", null: false
    t.integer "rep_scheme_idx"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movement_id"], name: "index_training_items_movements_on_movement_id"
    t.index ["training_item_id"], name: "index_training_items_movements_on_training_item_id"
  end

  create_table "training_items_results", force: :cascade do |t|
    t.integer "training_item_id", null: false
    t.integer "index"
    t.integer "reps"
    t.integer "weight"
    t.text "unit"
    t.boolean "miss"
    t.integer "set_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_item_id"], name: "index_training_items_results_on_training_item_id"
  end

  create_table "trainings", force: :cascade do |t|
    t.integer "raw_training_id"
    t.text "title"
    t.datetime "date", precision: nil
    t.integer "state"
    t.text "warmup"
    t.text "cooldown"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["raw_training_id"], name: "index_trainings_on_raw_training_id"
  end

  add_foreign_key "raw_training_items", "raw_trainings"
  add_foreign_key "training_items", "raw_training_items", column: "raw_training_items_id"
  add_foreign_key "training_items", "trainings"
  add_foreign_key "training_items_movements", "movements"
  add_foreign_key "training_items_movements", "training_items"
  add_foreign_key "training_items_results", "training_items"
end
