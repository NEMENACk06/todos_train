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

ActiveRecord::Schema[8.0].define(version: 2025_08_18_040600) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "color"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name"
    t.index ["position"], name: "index_categories_on_position"
  end

  create_table "todos", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "title", null: false
    t.text "notes"
    t.boolean "is_done", default: false, null: false
    t.integer "priority_level", default: 0, null: false
    t.date "due_on"
    t.time "due_time"
    t.integer "position", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id", "position"], name: "index_todos_on_category_id_and_position"
    t.index ["category_id"], name: "index_todos_on_category_id"
    t.index ["is_done"], name: "index_todos_on_is_done"
    t.index ["priority_level"], name: "index_todos_on_priority_level"
  end

  add_foreign_key "todos", "categories"
end
