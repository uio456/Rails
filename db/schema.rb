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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_09_05_003034) do

  create_table "candidates", force: :cascade do |t|
    t.string "name"
    t.string "party"
    t.text "politics"
    t.integer "age"
    t.integer "votes", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vote_log_count"
    t.integer "view", default: 0
  end

  create_table "friends", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.boolean "status", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "member_id"
    t.integer "friend_id"
    t.boolean "status", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_friendships_on_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.string "role", default: "normal", null: false
    t.string "avatar"
    t.text "intor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "member_id"
    t.string "authority", default: "All"
    t.string "view_counts", default: "0"
    t.boolean "public", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_posts_on_member_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "price"
    t.boolean "is_available"
    t.integer "store_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_products_on_store_id"
  end

  create_table "stores", force: :cascade do |t|
    t.string "title"
    t.string "price"
    t.string "address"
    t.string "tel"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_stores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "tel"
    t.string "intro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vote_logs", force: :cascade do |t|
    t.integer "candidate_id"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["candidate_id"], name: "index_vote_logs_on_candidate_id"
  end

  create_table "ware_houses", force: :cascade do |t|
    t.integer "store_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_ware_houses_on_product_id"
    t.index ["store_id"], name: "index_ware_houses_on_store_id"
  end

end
