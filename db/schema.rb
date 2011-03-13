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

ActiveRecord::Schema.define(:version => 20110313230710) do

  create_table "nodes", :force => true do |t|
    t.integer "nid",        :null => false
    t.string  "pids"
    t.text    "label"
    t.float   "weight"
    t.integer "profile_id"
  end

  create_table "profiles", :force => true do |t|
    t.string   "path_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", :id => false, :force => true do |t|
    t.integer "parent_id"
    t.integer "child_id"
  end

  add_index "relationships", ["child_id"], :name => "index_relationships_on_child_id"
  add_index "relationships", ["parent_id"], :name => "index_relationships_on_parent_id"

end
