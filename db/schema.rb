# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111022143129) do

  create_table "class_resources", :force => true do |t|
    t.string   "title"
    t.string   "presentation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", :force => true do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.integer "blocker_id"
    t.boolean "pending",    :default => true
  end

  add_index "friendships", ["user_id", "friend_id"], :name => "index_friendships_on_user_id_and_friend_id", :unique => true

  create_table "images", :force => true do |t|
    t.text     "image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lesson_id"
  end

  create_table "lessons", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "notebook_id"
    t.integer  "user_id"
    t.integer  "permission"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notebooks", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "course"
    t.string   "lecturer"
  end

  add_index "notebooks", ["user_id"], :name => "index_notebooks_on_user_id"

  create_table "presentaions", :force => true do |t|
    t.text     "slide"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "presentations", :force => true do |t|
    t.text     "slide"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lesson_id"
  end

  create_table "shares", :force => true do |t|
    t.integer  "lesson_id"
    t.string   "shared_ids"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "texts", :force => true do |t|
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "lesson_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           :default => false
  end

end
