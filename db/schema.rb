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

ActiveRecord::Schema.define(version: 2018_11_05_082720) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "allowed_domains", force: :cascade do |t|
    t.string "domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contact_addresses", force: :cascade do |t|
    t.string "type"
    t.bigint "contact_id"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contact_addresses_on_contact_id"
  end

  create_table "contact_emails", force: :cascade do |t|
    t.string "type"
    t.bigint "contact_id"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contact_emails_on_contact_id"
  end

  create_table "contact_numbers", force: :cascade do |t|
    t.string "type"
    t.bigint "contact_id"
    t.string "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_contact_numbers_on_contact_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.bigint "group_id"
    t.bigint "user_id"
    t.boolean "is_favorite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_contacts_on_group_id"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.boolean "is_favorite"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "status", default: true
    t.index ["user_id"], name: "index_groups_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_user_roles_on_role_id"
    t.index ["user_id"], name: "index_user_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "personal_identity_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["personal_identity_number"], name: "index_users_on_personal_identity_number", unique: true
  end

  add_foreign_key "contact_addresses", "contacts"
  add_foreign_key "contact_emails", "contacts"
  add_foreign_key "contact_numbers", "contacts"
  add_foreign_key "contacts", "groups"
  add_foreign_key "contacts", "users"
  add_foreign_key "groups", "users"
  add_foreign_key "user_roles", "roles"
  add_foreign_key "user_roles", "users"
end
