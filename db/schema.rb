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

ActiveRecord::Schema.define(:version => 20101224144101) do

  create_table "assets", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "collection_id"
    t.integer  "width"
    t.integer  "height"
    t.integer  "position"
    t.integer  "parent_id"
  end

  create_table "common_files", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "asset_file_file_name"
    t.string   "asset_file_content_type"
    t.integer  "asset_file_file_size"
    t.datetime "asset_file_updated_at"
  end

  create_table "descriptions", :force => true do |t|
    t.integer  "descriptionable_id"
    t.string   "descriptionable_type"
    t.text     "content"
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "folders", :force => true do |t|
    t.integer  "theme_id"
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_data_contents", :force => true do |t|
    t.integer  "item_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale"
    t.boolean  "active",     :default => true
  end

  create_table "items", :force => true do |t|
    t.integer  "theme_item_id"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",        :default => true
  end

  create_table "languages", :force => true do |t|
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "long_language"
  end

  create_table "linked_page_items", :force => true do |t|
    t.integer  "page_id"
    t.integer  "page_item_id"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "localizables", :force => true do |t|
    t.string   "localizable_type"
    t.integer  "localizable_id"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_items", :force => true do |t|
    t.string   "name"
    t.string   "language"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "english_name"
    t.integer  "theme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "website_id"
    t.boolean  "active",       :default => false
    t.integer  "parent_id"
    t.string   "name"
    t.integer  "position"
    t.string   "page_kind"
  end

  create_table "recipients", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "theme_items", :force => true do |t|
    t.integer  "theme_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "item_kind"
  end

  create_table "theme_uploads", :force => true do |t|
    t.integer  "theme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "theme_file_file_name"
    t.string   "theme_file_content_type"
    t.integer  "theme_file_file_size"
    t.datetime "theme_file_updated_at"
  end

  create_table "themes", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "theme_content"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subdomain"
    t.string   "domain"
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "websites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "start_page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
