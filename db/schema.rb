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

ActiveRecord::Schema[7.1].define(version: 2024_06_01_120410) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id", null: false
    t.bigint "last_user_commented_id"
    t.bigint "question_id", null: false
    t.integer "comments_count", default: 0
    t.string "creation_type"
    t.string "last_user_commented_type"
    t.boolean "published", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["last_user_commented_id"], name: "index_answers_on_last_user_commented_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.bigint "user_id", null: false
    t.string "commented_to_type"
    t.integer "commented_to_id"
    t.string "creation_type"
    t.boolean "published", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "question_tags", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_tags_on_question_id"
    t.index ["tag_id"], name: "index_question_tags_on_tag_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.bigint "user_id", null: false
    t.bigint "last_user_commented_id"
    t.bigint "last_user_answered_id"
    t.integer "views", default: 0
    t.integer "answers_count", default: 0
    t.integer "comments_count", default: 0
    t.string "creation_type"
    t.string "slug"
    t.string "last_user_commented_type"
    t.string "last_user_answered_type"
    t.boolean "published", default: true
    t.string "location", default: "EN"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["last_user_answered_id"], name: "index_questions_on_last_user_answered_id"
    t.index ["last_user_commented_id"], name: "index_questions_on_last_user_commented_id"
    t.index ["slug"], name: "index_questions_on_slug", unique: true
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "creation_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "password"
    t.string "clerk_id"
    t.string "picture"
    t.string "location"
    t.string "country"
    t.string "bio"
    t.string "city"
    t.string "youtube_link"
    t.string "linkedin_link"
    t.string "facebook_link"
    t.string "instagram_link"
    t.string "github_link"
    t.string "x_link"
    t.string "creation_type"
    t.integer "reputation", default: 0
    t.integer "answers_count", default: 0
    t.integer "questions_count", default: 0
    t.integer "comments_count", default: 0
    t.boolean "published", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "answers", "users", column: "last_user_commented_id"
  add_foreign_key "comments", "users"
  add_foreign_key "question_tags", "questions"
  add_foreign_key "question_tags", "tags"
  add_foreign_key "questions", "users"
  add_foreign_key "questions", "users", column: "last_user_answered_id"
  add_foreign_key "questions", "users", column: "last_user_commented_id"
end
