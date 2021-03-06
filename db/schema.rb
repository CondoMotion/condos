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

ActiveRecord::Schema.define(:version => 20121128051331) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "owner_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.integer  "site_id"
    t.integer  "user_id"
    t.integer  "permission"
    t.string   "attachment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "documents", ["site_id"], :name => "index_documents_on_site_id"
  add_index "documents", ["user_id"], :name => "index_documents_on_user_id"

  create_table "memberships", :force => true do |t|
    t.integer  "site_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "role_id"
  end

  add_index "memberships", ["site_id"], :name => "index_memberships_on_site_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "news", :force => true do |t|
    t.string   "title"
    t.integer  "site_id"
    t.integer  "user_id"
    t.integer  "permission"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "content"
  end

  add_index "news", ["site_id"], :name => "index_news_on_site_id"
  add_index "news", ["user_id"], :name => "index_news_on_user_id"

  create_table "photos", :force => true do |t|
    t.string   "title"
    t.integer  "site_id"
    t.integer  "user_id"
    t.integer  "permission"
    t.string   "attachment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "photos", ["site_id"], :name => "index_photos_on_site_id"
  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "posts", :force => true do |t|
    t.integer  "site_id"
    t.integer  "fields_id"
    t.string   "fields_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "roles", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.integer  "permission"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roles", ["company_id"], :name => "index_roles_on_company_id"

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "subdomain"
    t.integer  "company_id"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.text     "description"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "layout_name"
    t.text     "custom_layout_content"
    t.integer  "post_id"
    t.string   "post_type"
  end

  add_index "sites", ["company_id"], :name => "index_sites_on_company_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "fullname"
    t.boolean  "manager"
    t.integer  "company_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
