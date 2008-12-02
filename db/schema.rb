# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081127001146) do

  create_table "feature_project_relationships", :force => true do |t|
    t.integer  "feature_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "features", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "risk"
    t.string   "rank"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name",        :limit => 50, :default => "",                    :null => false
    t.text     "description",               :default => "",                    :null => false
    t.datetime "open_date",                 :default => '2008-12-02 11:11:43', :null => false
    t.datetime "close_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requirements", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "status"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_plans", :force => true do |t|
    t.text     "description"
    t.integer  "requirement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_project_relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username",        :limit => 25, :default => "", :null => false
    t.string   "hashed_password", :limit => 40, :default => "", :null => false
    t.string   "first_name",      :limit => 25, :default => "", :null => false
    t.string   "last_name",       :limit => 40, :default => "", :null => false
    t.string   "email",           :limit => 50, :default => "", :null => false
    t.string   "company_name",    :limit => 50, :default => ""
    t.string   "role",            :limit => 1,  :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
