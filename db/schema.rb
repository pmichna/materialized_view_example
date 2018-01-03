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

ActiveRecord::Schema.define(version: 20180103145026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "permission_associations", force: :cascade do |t|
    t.bigint "permission_id", null: false
    t.bigint "permission_group_id", null: false
    t.index ["permission_group_id"], name: "index_permission_associations_on_permission_group_id"
    t.index ["permission_id"], name: "index_permission_associations_on_permission_id"
  end

  create_table "permission_groups", force: :cascade do |t|
  end

  create_table "permissions", force: :cascade do |t|
    t.integer "name", null: false
  end

  create_table "user_permission_groups", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "permission_group_id", null: false
    t.index ["permission_group_id"], name: "index_user_permission_groups_on_permission_group_id"
    t.index ["user_id"], name: "index_user_permission_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
  end

  add_foreign_key "permission_associations", "permission_groups"
  add_foreign_key "permission_associations", "permissions"
  add_foreign_key "user_permission_groups", "permission_groups"
  add_foreign_key "user_permission_groups", "users"

  create_view "permissions_check_results", materialized: true,  sql_definition: <<-SQL
      SELECT users.id AS user_id,
      permissions.name AS permission_name
     FROM ((((users
       JOIN user_permission_groups ON ((user_permission_groups.user_id = users.id)))
       JOIN permission_groups ON ((permission_groups.id = user_permission_groups.permission_group_id)))
       JOIN permission_associations ON ((permission_associations.permission_group_id = permission_groups.id)))
       JOIN permissions ON ((permission_associations.permission_id = permissions.id)))
    GROUP BY users.id, permissions.name;
  SQL

end
