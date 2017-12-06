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

ActiveRecord::Schema.define(version: 20171120151130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "branch"
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "contact_id"
    t.boolean "accepted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contacts_on_contact_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "group_conversations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_conversations_users", id: false, force: :cascade do |t|
    t.integer "conversation_id"
    t.integer "user_id"
    t.index ["conversation_id"], name: "index_group_conversations_users_on_conversation_id"
    t.index ["user_id"], name: "index_group_conversations_users_on_user_id"
  end

  create_table "group_messages", force: :cascade do |t|
    t.string "content"
    t.string "added_new_users"
    t.string "seen_by"
    t.bigint "user_id"
    t.bigint "conversation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_group_messages_on_conversation_id"
    t.index ["user_id"], name: "index_group_messages_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "category_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_posts_on_category_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "private_conversations", force: :cascade do |t|
    t.integer "recipient_id"
    t.integer "sender_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipient_id", "sender_id"], name: "index_private_conversations_on_recipient_id_and_sender_id", unique: true
    t.index ["recipient_id"], name: "index_private_conversations_on_recipient_id"
    t.index ["sender_id"], name: "index_private_conversations_on_sender_id"
  end

  create_table "private_messages", force: :cascade do |t|
    t.text "body"
    t.bigint "user_id"
    t.bigint "conversation_id"
    t.boolean "seen", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_private_messages_on_conversation_id"
    t.index ["user_id"], name: "index_private_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "private_messages", "users"
end
