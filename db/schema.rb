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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150913141111) do

  create_table "events", force: true do |t|
    t.string   "name"
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poll_options", force: true do |t|
    t.integer  "poll_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "votes"
  end

  create_table "polls", force: true do |t|
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "open",       default: false
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "author_id"
    t.string   "status"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unit_memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unit_position_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unit_positions", force: true do |t|
    t.string   "name"
    t.integer  "unit_id"
    t.integer  "position_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
  end

  add_index "units", ["ancestry"], name: "index_units_on_ancestry", using: :btree

  create_table "user_polls", force: true do |t|
    t.integer "user_id"
    t.integer "poll_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "username"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
    t.integer  "wordpress_id"
    t.string   "phone_number"
    t.string   "address"
    t.string   "postal_code"
    t.string   "city"
    t.date     "birth_date"
    t.integer  "class_year"
    t.string   "orientation"
    t.string   "gender"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wp_batch_create_queue", primary_key: "batch_create_ID", force: true do |t|
    t.integer "batch_create_site",       limit: 8
    t.string  "batch_create_blog_name",            default: "null", null: false
    t.string  "batch_create_blog_title",           default: "null", null: false
    t.string  "batch_create_user_name",            default: "null", null: false
    t.string  "batch_create_user_pass",            default: "null", null: false
    t.string  "batch_create_user_email",           default: "null", null: false
    t.string  "batch_create_user_role",            default: "null", null: false
  end

  create_table "wp_bb_forums", primary_key: "forum_id", force: true do |t|
    t.string  "forum_name",   limit: 150, default: "", null: false
    t.string  "forum_slug",               default: "", null: false
    t.text    "forum_desc",                            null: false
    t.integer "forum_parent",             default: 0,  null: false
    t.integer "forum_order",              default: 0,  null: false
    t.integer "topics",       limit: 8,   default: 0,  null: false
    t.integer "posts",        limit: 8,   default: 0,  null: false
  end

  add_index "wp_bb_forums", ["forum_slug"], name: "forum_slug", using: :btree

  create_table "wp_bb_meta", primary_key: "meta_id", force: true do |t|
    t.string  "object_type", limit: 16,         default: "bb_option", null: false
    t.integer "object_id",   limit: 8,          default: 0,           null: false
    t.string  "meta_key"
    t.text    "meta_value",  limit: 2147483647
  end

  add_index "wp_bb_meta", ["object_type", "meta_key"], name: "object_type__meta_key", using: :btree
  add_index "wp_bb_meta", ["object_type", "object_id", "meta_key"], name: "object_type__object_id__meta_key", using: :btree

  create_table "wp_bb_posts", primary_key: "post_id", force: true do |t|
    t.integer  "forum_id",                 default: 1,     null: false
    t.integer  "topic_id",      limit: 8,  default: 1,     null: false
    t.integer  "poster_id",                default: 0,     null: false
    t.text     "post_text",                                null: false
    t.datetime "post_time",                                null: false
    t.string   "poster_ip",     limit: 15, default: "",    null: false
    t.boolean  "post_status",              default: false, null: false
    t.integer  "post_position", limit: 8,  default: 0,     null: false
  end

  add_index "wp_bb_posts", ["post_text"], name: "post_text", type: :fulltext
  add_index "wp_bb_posts", ["post_time"], name: "post_time", using: :btree
  add_index "wp_bb_posts", ["poster_id", "post_time"], name: "poster_time", using: :btree
  add_index "wp_bb_posts", ["topic_id", "post_time"], name: "topic_time", using: :btree

  create_table "wp_bb_term_relationships", id: false, force: true do |t|
    t.integer "object_id",        limit: 8, default: 0, null: false
    t.integer "term_taxonomy_id", limit: 8, default: 0, null: false
    t.integer "user_id",          limit: 8, default: 0, null: false
    t.integer "term_order",                 default: 0, null: false
  end

  add_index "wp_bb_term_relationships", ["term_taxonomy_id"], name: "term_taxonomy_id", using: :btree

  create_table "wp_bb_term_taxonomy", primary_key: "term_taxonomy_id", force: true do |t|
    t.integer "term_id",     limit: 8,          default: 0,  null: false
    t.string  "taxonomy",    limit: 32,         default: "", null: false
    t.text    "description", limit: 2147483647,              null: false
    t.integer "parent",      limit: 8,          default: 0,  null: false
    t.integer "count",       limit: 8,          default: 0,  null: false
  end

  add_index "wp_bb_term_taxonomy", ["taxonomy"], name: "taxonomy", using: :btree
  add_index "wp_bb_term_taxonomy", ["term_id", "taxonomy"], name: "term_id_taxonomy", unique: true, using: :btree

  create_table "wp_bb_terms", primary_key: "term_id", force: true do |t|
    t.string  "name",       limit: 55,  default: "", null: false
    t.string  "slug",       limit: 200, default: "", null: false
    t.integer "term_group", limit: 8,   default: 0,  null: false
  end

  add_index "wp_bb_terms", ["name"], name: "name", using: :btree
  add_index "wp_bb_terms", ["slug"], name: "slug", unique: true, using: :btree

  create_table "wp_bb_topics", primary_key: "topic_id", force: true do |t|
    t.string   "topic_title",            limit: 100, default: "",          null: false
    t.string   "topic_slug",                         default: "",          null: false
    t.integer  "topic_poster",           limit: 8,   default: 0,           null: false
    t.string   "topic_poster_name",      limit: 40,  default: "Anonymous", null: false
    t.integer  "topic_last_poster",      limit: 8,   default: 0,           null: false
    t.string   "topic_last_poster_name", limit: 40,  default: "",          null: false
    t.datetime "topic_start_time",                                         null: false
    t.datetime "topic_time",                                               null: false
    t.integer  "forum_id",                           default: 1,           null: false
    t.boolean  "topic_status",                       default: false,       null: false
    t.boolean  "topic_open",                         default: true,        null: false
    t.integer  "topic_last_post_id",     limit: 8,   default: 1,           null: false
    t.boolean  "topic_sticky",                       default: false,       null: false
    t.integer  "topic_posts",            limit: 8,   default: 0,           null: false
    t.integer  "tag_count",              limit: 8,   default: 0,           null: false
  end

  add_index "wp_bb_topics", ["forum_id", "topic_time"], name: "forum_time", using: :btree
  add_index "wp_bb_topics", ["topic_poster", "topic_start_time"], name: "user_start_time", using: :btree
  add_index "wp_bb_topics", ["topic_slug"], name: "topic_slug", using: :btree
  add_index "wp_bb_topics", ["topic_status", "topic_sticky", "topic_time"], name: "stickies", using: :btree

  create_table "wp_bp_activity", force: true do |t|
    t.integer  "user_id",           limit: 8,                          null: false
    t.string   "component",         limit: 75,                         null: false
    t.string   "type",              limit: 75,                         null: false
    t.text     "action",                                               null: false
    t.text     "content",           limit: 2147483647,                 null: false
    t.string   "primary_link",      limit: 150,                        null: false
    t.string   "item_id",           limit: 75,                         null: false
    t.string   "secondary_item_id", limit: 75
    t.datetime "date_recorded",                                        null: false
    t.boolean  "hide_sitewide",                        default: false
    t.integer  "mptt_left",                            default: 0,     null: false
    t.integer  "mptt_right",                           default: 0,     null: false
  end

  add_index "wp_bp_activity", ["component"], name: "component", using: :btree
  add_index "wp_bp_activity", ["date_recorded"], name: "date_recorded", using: :btree
  add_index "wp_bp_activity", ["hide_sitewide"], name: "hide_sitewide", using: :btree
  add_index "wp_bp_activity", ["item_id"], name: "item_id", using: :btree
  add_index "wp_bp_activity", ["mptt_left"], name: "mptt_left", using: :btree
  add_index "wp_bp_activity", ["mptt_right"], name: "mptt_right", using: :btree
  add_index "wp_bp_activity", ["secondary_item_id"], name: "secondary_item_id", using: :btree
  add_index "wp_bp_activity", ["type"], name: "type", using: :btree
  add_index "wp_bp_activity", ["user_id"], name: "user_id", using: :btree

  create_table "wp_bp_activity_meta", force: true do |t|
    t.integer "activity_id", limit: 8,          null: false
    t.string  "meta_key"
    t.text    "meta_value",  limit: 2147483647
  end

  add_index "wp_bp_activity_meta", ["activity_id"], name: "activity_id", using: :btree
  add_index "wp_bp_activity_meta", ["meta_key"], name: "meta_key", using: :btree

  create_table "wp_bp_groups", force: true do |t|
    t.integer  "creator_id",   limit: 8,                             null: false
    t.string   "name",         limit: 100,                           null: false
    t.string   "slug",         limit: 200,                           null: false
    t.text     "description",  limit: 2147483647,                    null: false
    t.string   "status",       limit: 10,         default: "public", null: false
    t.boolean  "enable_forum",                    default: true,     null: false
    t.datetime "date_created",                                       null: false
  end

  add_index "wp_bp_groups", ["creator_id"], name: "creator_id", using: :btree
  add_index "wp_bp_groups", ["status"], name: "status", using: :btree

  create_table "wp_bp_groups_calendars", force: true do |t|
    t.integer  "group_id",          limit: 8, default: 0, null: false
    t.integer  "user_id",           limit: 8, default: 0, null: false
    t.datetime "event_time",                              null: false
    t.text     "event_title",                             null: false
    t.text     "event_description"
    t.text     "event_location"
    t.boolean  "event_map",                               null: false
    t.integer  "created_stamp",     limit: 8,             null: false
    t.integer  "last_edited_id",    limit: 8, default: 0, null: false
    t.integer  "last_edited_stamp", limit: 8,             null: false
  end

  create_table "wp_bp_groups_groupmeta", force: true do |t|
    t.integer "group_id",   limit: 8,          null: false
    t.string  "meta_key"
    t.text    "meta_value", limit: 2147483647
  end

  add_index "wp_bp_groups_groupmeta", ["group_id"], name: "group_id", using: :btree
  add_index "wp_bp_groups_groupmeta", ["meta_key"], name: "meta_key", using: :btree

  create_table "wp_bp_groups_members", force: true do |t|
    t.integer  "group_id",      limit: 8,                          null: false
    t.integer  "user_id",       limit: 8,                          null: false
    t.integer  "inviter_id",    limit: 8,                          null: false
    t.boolean  "is_admin",                         default: false, null: false
    t.boolean  "is_mod",                           default: false, null: false
    t.string   "user_title",    limit: 100,                        null: false
    t.datetime "date_modified",                                    null: false
    t.text     "comments",      limit: 2147483647,                 null: false
    t.boolean  "is_confirmed",                     default: false, null: false
    t.boolean  "is_banned",                        default: false, null: false
    t.boolean  "invite_sent",                      default: false, null: false
  end

  add_index "wp_bp_groups_members", ["group_id"], name: "group_id", using: :btree
  add_index "wp_bp_groups_members", ["inviter_id"], name: "inviter_id", using: :btree
  add_index "wp_bp_groups_members", ["is_admin"], name: "is_admin", using: :btree
  add_index "wp_bp_groups_members", ["is_confirmed"], name: "is_confirmed", using: :btree
  add_index "wp_bp_groups_members", ["is_mod"], name: "is_mod", using: :btree
  add_index "wp_bp_groups_members", ["user_id"], name: "user_id", using: :btree

  create_table "wp_bp_messages_messages", force: true do |t|
    t.integer  "thread_id", limit: 8,          null: false
    t.integer  "sender_id", limit: 8,          null: false
    t.string   "subject",   limit: 200,        null: false
    t.text     "message",   limit: 2147483647, null: false
    t.datetime "date_sent",                    null: false
  end

  add_index "wp_bp_messages_messages", ["sender_id"], name: "sender_id", using: :btree
  add_index "wp_bp_messages_messages", ["thread_id"], name: "thread_id", using: :btree

  create_table "wp_bp_messages_notices", force: true do |t|
    t.string   "subject",   limit: 200,                        null: false
    t.text     "message",   limit: 2147483647,                 null: false
    t.datetime "date_sent",                                    null: false
    t.boolean  "is_active",                    default: false, null: false
  end

  add_index "wp_bp_messages_notices", ["is_active"], name: "is_active", using: :btree

  create_table "wp_bp_messages_recipients", force: true do |t|
    t.integer "user_id",      limit: 8,                 null: false
    t.integer "thread_id",    limit: 8,                 null: false
    t.integer "unread_count",           default: 0,     null: false
    t.boolean "sender_only",            default: false, null: false
    t.boolean "is_deleted",             default: false, null: false
  end

  add_index "wp_bp_messages_recipients", ["is_deleted"], name: "is_deleted", using: :btree
  add_index "wp_bp_messages_recipients", ["sender_only"], name: "sender_only", using: :btree
  add_index "wp_bp_messages_recipients", ["thread_id"], name: "thread_id", using: :btree
  add_index "wp_bp_messages_recipients", ["unread_count"], name: "unread_count", using: :btree
  add_index "wp_bp_messages_recipients", ["user_id"], name: "user_id", using: :btree

  create_table "wp_bp_notifications", force: true do |t|
    t.integer  "user_id",           limit: 8,                  null: false
    t.integer  "item_id",           limit: 8,                  null: false
    t.integer  "secondary_item_id", limit: 8
    t.string   "component_name",    limit: 75,                 null: false
    t.string   "component_action",  limit: 75,                 null: false
    t.datetime "date_notified",                                null: false
    t.boolean  "is_new",                       default: false, null: false
  end

  add_index "wp_bp_notifications", ["component_action"], name: "component_action", using: :btree
  add_index "wp_bp_notifications", ["component_name"], name: "component_name", using: :btree
  add_index "wp_bp_notifications", ["is_new"], name: "is_new", using: :btree
  add_index "wp_bp_notifications", ["item_id"], name: "item_id", using: :btree
  add_index "wp_bp_notifications", ["secondary_item_id"], name: "secondary_item_id", using: :btree
  add_index "wp_bp_notifications", ["user_id", "is_new"], name: "useritem", using: :btree
  add_index "wp_bp_notifications", ["user_id"], name: "user_id", using: :btree

  create_table "wp_bp_user_blogs", force: true do |t|
    t.integer "user_id", limit: 8, null: false
    t.integer "blog_id", limit: 8, null: false
  end

  add_index "wp_bp_user_blogs", ["blog_id"], name: "blog_id", using: :btree
  add_index "wp_bp_user_blogs", ["user_id"], name: "user_id", using: :btree

  create_table "wp_bp_user_blogs_blogmeta", force: true do |t|
    t.integer "blog_id",    limit: 8,          null: false
    t.string  "meta_key"
    t.text    "meta_value", limit: 2147483647
  end

  add_index "wp_bp_user_blogs_blogmeta", ["blog_id"], name: "blog_id", using: :btree
  add_index "wp_bp_user_blogs_blogmeta", ["meta_key"], name: "meta_key", using: :btree

  create_table "wp_bp_xprofile_data", force: true do |t|
    t.integer  "field_id",     limit: 8,          null: false
    t.integer  "user_id",      limit: 8,          null: false
    t.text     "value",        limit: 2147483647, null: false
    t.datetime "last_updated",                    null: false
  end

  add_index "wp_bp_xprofile_data", ["field_id"], name: "field_id", using: :btree
  add_index "wp_bp_xprofile_data", ["user_id"], name: "user_id", using: :btree

  create_table "wp_bp_xprofile_fields", force: true do |t|
    t.integer "group_id",          limit: 8,                          null: false
    t.integer "parent_id",         limit: 8,                          null: false
    t.string  "type",              limit: 150,                        null: false
    t.string  "name",              limit: 150,                        null: false
    t.text    "description",       limit: 2147483647,                 null: false
    t.boolean "is_required",                          default: false, null: false
    t.boolean "is_default_option",                    default: false, null: false
    t.integer "field_order",       limit: 8,          default: 0,     null: false
    t.integer "option_order",      limit: 8,          default: 0,     null: false
    t.string  "order_by",          limit: 15,         default: "",    null: false
    t.boolean "can_delete",                           default: true,  null: false
  end

  add_index "wp_bp_xprofile_fields", ["can_delete"], name: "can_delete", using: :btree
  add_index "wp_bp_xprofile_fields", ["field_order"], name: "field_order", using: :btree
  add_index "wp_bp_xprofile_fields", ["group_id"], name: "group_id", using: :btree
  add_index "wp_bp_xprofile_fields", ["is_required"], name: "is_required", using: :btree
  add_index "wp_bp_xprofile_fields", ["parent_id"], name: "parent_id", using: :btree

  create_table "wp_bp_xprofile_groups", force: true do |t|
    t.string  "name",        limit: 150,                  null: false
    t.text    "description", limit: 16777215,             null: false
    t.integer "group_order", limit: 8,        default: 0, null: false
    t.boolean "can_delete",                               null: false
  end

  add_index "wp_bp_xprofile_groups", ["can_delete"], name: "can_delete", using: :btree

  create_table "wp_bp_xprofile_meta", force: true do |t|
    t.integer "object_id",   limit: 8,          null: false
    t.string  "object_type", limit: 150,        null: false
    t.string  "meta_key"
    t.text    "meta_value",  limit: 2147483647
  end

  add_index "wp_bp_xprofile_meta", ["meta_key"], name: "meta_key", using: :btree
  add_index "wp_bp_xprofile_meta", ["object_id"], name: "object_id", using: :btree

  create_table "wp_chat_log", force: true do |t|
    t.integer   "blog_id", null: false
    t.integer   "chat_id", null: false
    t.timestamp "start",   null: false
    t.timestamp "end",     null: false
    t.timestamp "created", null: false
  end

  add_index "wp_chat_log", ["blog_id"], name: "blog_id", using: :btree
  add_index "wp_chat_log", ["chat_id"], name: "chat_id", using: :btree

  create_table "wp_chat_message", force: true do |t|
    t.integer   "blog_id",                               null: false
    t.integer   "chat_id",                               null: false
    t.timestamp "timestamp",                             null: false
    t.string    "name",                                  null: false
    t.string    "avatar",    limit: 1024,                null: false
    t.text      "message",                               null: false
    t.string    "moderator", limit: 3,    default: "no", null: false
    t.string    "archived",  limit: 3,    default: "no", null: false
  end

  add_index "wp_chat_message", ["archived"], name: "archived", using: :btree
  add_index "wp_chat_message", ["blog_id"], name: "blog_id", using: :btree
  add_index "wp_chat_message", ["chat_id"], name: "chat_id", using: :btree
  add_index "wp_chat_message", ["timestamp"], name: "timestamp", using: :btree

  create_table "wp_commentmeta", primary_key: "meta_id", force: true do |t|
    t.integer "comment_id", limit: 8,          default: 0, null: false
    t.string  "meta_key"
    t.text    "meta_value", limit: 2147483647
  end

  add_index "wp_commentmeta", ["comment_id"], name: "comment_id", using: :btree
  add_index "wp_commentmeta", ["meta_key"], name: "meta_key", using: :btree

  create_table "wp_comments", primary_key: "comment_ID", force: true do |t|
    t.integer  "comment_post_ID",      limit: 8,   default: 0,   null: false
    t.text     "comment_author",       limit: 255,               null: false
    t.string   "comment_author_email", limit: 100, default: "",  null: false
    t.string   "comment_author_url",   limit: 200, default: "",  null: false
    t.string   "comment_author_IP",    limit: 100, default: "",  null: false
    t.datetime "comment_date",                                   null: false
    t.datetime "comment_date_gmt",                               null: false
    t.text     "comment_content",                                null: false
    t.integer  "comment_karma",                    default: 0,   null: false
    t.string   "comment_approved",     limit: 20,  default: "1", null: false
    t.string   "comment_agent",                    default: "",  null: false
    t.string   "comment_type",         limit: 20,  default: "",  null: false
    t.integer  "comment_parent",       limit: 8,   default: 0,   null: false
    t.integer  "user_id",              limit: 8,   default: 0,   null: false
  end

  add_index "wp_comments", ["comment_approved", "comment_date_gmt"], name: "comment_approved_date_gmt", using: :btree
  add_index "wp_comments", ["comment_approved"], name: "comment_approved", using: :btree
  add_index "wp_comments", ["comment_date_gmt"], name: "comment_date_gmt", using: :btree
  add_index "wp_comments", ["comment_parent"], name: "comment_parent", using: :btree
  add_index "wp_comments", ["comment_post_ID"], name: "comment_post_ID", using: :btree

  create_table "wp_enewsletter_groups", primary_key: "group_id", force: true do |t|
    t.string "group_name",           null: false
    t.string "public",     limit: 1, null: false
  end

  create_table "wp_enewsletter_member_group", id: false, force: true do |t|
    t.integer "member_id", null: false
    t.integer "group_id",  null: false
  end

  create_table "wp_enewsletter_members", primary_key: "member_id", force: true do |t|
    t.integer "wp_user_id",                  default: 0
    t.string  "member_fname"
    t.string  "member_lname"
    t.string  "member_email",                            null: false
    t.integer "join_date",                               null: false
    t.text    "member_info"
    t.string  "unsubscribe_code", limit: 20
  end

  create_table "wp_enewsletter_newsletters", primary_key: "newsletter_id", force: true do |t|
    t.integer "create_date",              null: false
    t.string  "template",     limit: 100, null: false
    t.string  "subject",                  null: false
    t.string  "from_name",                null: false
    t.string  "from_email",               null: false
    t.text    "content",                  null: false
    t.string  "contact_info",             null: false
    t.string  "bounce_email",             null: false
  end

  create_table "wp_enewsletter_send", primary_key: "send_id", force: true do |t|
    t.integer "newsletter_id",             null: false
    t.integer "start_time",    default: 0
    t.integer "end_time",      default: 0
    t.text    "email_body"
  end

  create_table "wp_enewsletter_send_members", id: false, force: true do |t|
    t.integer "send_id",                            null: false
    t.integer "member_id",                          null: false
    t.string  "status",      limit: 15
    t.integer "opened_time",            default: 0
    t.integer "bounce_time",            default: 0
    t.integer "sent_time"
  end

  create_table "wp_enewsletter_settings", primary_key: "key", force: true do |t|
    t.string "value", null: false
  end

  create_table "wp_events_answer", force: true do |t|
    t.string  "registration_id", limit: 23,             null: false
    t.integer "attendee_id",                default: 0, null: false
    t.integer "question_id",                default: 0, null: false
    t.text    "answer",                                 null: false
  end

  add_index "wp_events_answer", ["attendee_id"], name: "attendee_id", using: :btree
  add_index "wp_events_answer", ["registration_id"], name: "registration_id", using: :btree

  create_table "wp_events_attendee", force: true do |t|
    t.string    "registration_id",     limit: 23,                           default: "0"
    t.string    "lname",               limit: 45
    t.string    "fname",               limit: 45
    t.string    "address",             limit: 45
    t.string    "address2",            limit: 45
    t.string    "city",                limit: 45
    t.string    "state",               limit: 45
    t.string    "zip",                 limit: 45
    t.string    "country_id",          limit: 128
    t.string    "organization_name",   limit: 50
    t.string    "vat_number",          limit: 20
    t.string    "email",               limit: 45
    t.string    "phone",               limit: 45
    t.timestamp "date",                                                                            null: false
    t.string    "payment",             limit: 45
    t.string    "payment_status",      limit: 45,                           default: "Incomplete"
    t.string    "txn_type",            limit: 45
    t.string    "txn_id",              limit: 45
    t.decimal   "amount_pd",                       precision: 20, scale: 2, default: 0.0
    t.decimal   "total_cost",                      precision: 20, scale: 2, default: 0.0
    t.string    "price_option",        limit: 100
    t.string    "coupon_code",         limit: 45
    t.string    "quantity",            limit: 5,                            default: "0"
    t.string    "payment_date",        limit: 45
    t.string    "event_id",            limit: 45
    t.string    "event_time",          limit: 15
    t.string    "end_time",            limit: 15
    t.string    "start_date",          limit: 45
    t.string    "end_date",            limit: 45
    t.string    "attendee_session",    limit: 250
    t.text      "transaction_details"
    t.integer   "pre_approve",                                              default: 1
    t.integer   "checked_in",                                               default: 0
    t.integer   "checked_in_quantity",                                      default: 0
    t.string    "hashSalt",            limit: 250
  end

  add_index "wp_events_attendee", ["event_id"], name: "event_id", using: :btree
  add_index "wp_events_attendee", ["registration_id"], name: "registration_id", using: :btree

  create_table "wp_events_attendee_cost", id: false, force: true do |t|
    t.integer "attendee_id"
    t.decimal "cost",        precision: 20, scale: 2, default: 0.0
    t.integer "quantity"
  end

  add_index "wp_events_attendee_cost", ["attendee_id"], name: "attendee_id", using: :btree

  create_table "wp_events_attendee_meta", primary_key: "ameta_id", force: true do |t|
    t.integer  "attendee_id"
    t.string   "meta_key"
    t.text     "meta_value",  limit: 2147483647
    t.datetime "date_added"
  end

  add_index "wp_events_attendee_meta", ["attendee_id"], name: "attendee_id", using: :btree

  create_table "wp_events_category_detail", id: false, force: true do |t|
    t.integer "id",                                          null: false
    t.string  "category_name",       limit: 100
    t.string  "category_identifier", limit: 45
    t.text    "category_desc"
    t.string  "display_desc",        limit: 4
    t.integer "wp_user",                         default: 1
    t.text    "category_meta"
  end

  add_index "wp_events_category_detail", ["category_identifier"], name: "category_identifier", using: :btree
  add_index "wp_events_category_detail", ["id"], name: "id", unique: true, using: :btree
  add_index "wp_events_category_detail", ["wp_user"], name: "wp_user", using: :btree

  create_table "wp_events_category_rel", force: true do |t|
    t.integer "event_id"
    t.integer "cat_id"
  end

  add_index "wp_events_category_rel", ["event_id"], name: "event_id", using: :btree

  create_table "wp_events_detail", force: true do |t|
    t.string   "event_code",            limit: 26,         default: "0"
    t.string   "event_name",            limit: 100
    t.text     "event_desc"
    t.string   "display_desc",          limit: 1,          default: "Y"
    t.string   "display_reg_form",      limit: 1,          default: "Y"
    t.string   "event_identifier",      limit: 75
    t.string   "start_date",            limit: 15
    t.string   "end_date",              limit: 15
    t.string   "registration_start",    limit: 15
    t.string   "registration_end",      limit: 15
    t.string   "registration_startT",   limit: 15
    t.string   "registration_endT",     limit: 15
    t.string   "visible_on",            limit: 15
    t.text     "address"
    t.text     "address2"
    t.string   "city",                  limit: 100
    t.string   "state",                 limit: 100
    t.string   "zip",                   limit: 11
    t.string   "phone",                 limit: 15
    t.string   "venue_title",           limit: 250
    t.string   "venue_url",             limit: 250
    t.text     "venue_image"
    t.string   "venue_phone",           limit: 15
    t.string   "virtual_url",           limit: 250
    t.string   "virtual_phone",         limit: 15
    t.string   "reg_limit",             limit: 25,         default: "999999"
    t.string   "allow_multiple",        limit: 15,         default: "N"
    t.integer  "additional_limit",                         default: 5
    t.string   "send_mail",             limit: 2,          default: "Y"
    t.string   "is_active",             limit: 1,          default: "Y"
    t.string   "event_status",          limit: 1,          default: "A"
    t.text     "conf_mail"
    t.string   "use_coupon_code",       limit: 1,          default: "N"
    t.string   "use_groupon_code",      limit: 1,          default: "N"
    t.text     "category_id"
    t.text     "coupon_id"
    t.float    "tax_percentage",        limit: 24
    t.integer  "tax_mode"
    t.string   "member_only",           limit: 1
    t.integer  "post_id"
    t.string   "post_type",             limit: 50
    t.string   "country",               limit: 200
    t.string   "externalURL"
    t.string   "early_disc",            limit: 10
    t.string   "early_disc_date",       limit: 15
    t.string   "early_disc_percentage", limit: 1,          default: "N"
    t.text     "question_groups",       limit: 2147483647
    t.text     "item_groups",           limit: 2147483647
    t.string   "event_type",            limit: 250
    t.string   "allow_overflow",        limit: 1,          default: "N"
    t.integer  "overflow_event_id",                        default: 0
    t.integer  "recurrence_id",                            default: 0
    t.integer  "email_id",                                 default: 0
    t.text     "alt_email"
    t.text     "event_meta",            limit: 2147483647
    t.integer  "wp_user",                                  default: 1
    t.integer  "require_pre_approval",                     default: 0
    t.string   "timezone_string",       limit: 250
    t.integer  "likes"
    t.datetime "submitted",                                                   null: false
    t.integer  "ticket_id",                                default: 0
  end

  add_index "wp_events_detail", ["city"], name: "city", using: :btree
  add_index "wp_events_detail", ["end_date"], name: "end_date", using: :btree
  add_index "wp_events_detail", ["event_code"], name: "event_code", using: :btree
  add_index "wp_events_detail", ["event_name"], name: "event_name", using: :btree
  add_index "wp_events_detail", ["event_status"], name: "event_status", using: :btree
  add_index "wp_events_detail", ["likes"], name: "likes", using: :btree
  add_index "wp_events_detail", ["recurrence_id"], name: "recurrence_id", using: :btree
  add_index "wp_events_detail", ["reg_limit"], name: "reg_limit", using: :btree
  add_index "wp_events_detail", ["registration_end"], name: "registration_end", using: :btree
  add_index "wp_events_detail", ["registration_start"], name: "registration_start", using: :btree
  add_index "wp_events_detail", ["start_date"], name: "start_date", using: :btree
  add_index "wp_events_detail", ["state"], name: "state", using: :btree
  add_index "wp_events_detail", ["submitted"], name: "submitted", using: :btree
  add_index "wp_events_detail", ["wp_user"], name: "wp_user", using: :btree

  create_table "wp_events_discount_codes", force: true do |t|
    t.string  "coupon_code",             limit: 50
    t.decimal "coupon_code_price",                  precision: 20, scale: 2
    t.string  "use_percentage",          limit: 1
    t.text    "coupon_code_description"
    t.string  "each_attendee",           limit: 1
    t.integer "wp_user",                                                     default: 1
  end

  add_index "wp_events_discount_codes", ["coupon_code"], name: "coupon_code", using: :btree
  add_index "wp_events_discount_codes", ["wp_user"], name: "wp_user", using: :btree

  create_table "wp_events_discount_rel", force: true do |t|
    t.integer "event_id"
    t.integer "discount_id"
  end

  add_index "wp_events_discount_rel", ["event_id"], name: "event_id", using: :btree

  create_table "wp_events_email", id: false, force: true do |t|
    t.integer "id",                                    null: false
    t.string  "email_name",    limit: 100
    t.string  "email_subject", limit: 250
    t.text    "email_text"
    t.integer "wp_user",                   default: 1
  end

  add_index "wp_events_email", ["id"], name: "id", unique: true, using: :btree
  add_index "wp_events_email", ["wp_user"], name: "wp_user", using: :btree

  create_table "wp_events_locale", id: false, force: true do |t|
    t.integer "id",                                   null: false
    t.string  "name",       limit: 250
    t.string  "identifier", limit: 26,  default: "0"
    t.integer "wp_user",                default: 1
  end

  add_index "wp_events_locale", ["id"], name: "id", unique: true, using: :btree
  add_index "wp_events_locale", ["identifier"], name: "identifier", using: :btree
  add_index "wp_events_locale", ["wp_user"], name: "wp_user", using: :btree

  create_table "wp_events_locale_rel", force: true do |t|
    t.integer "venue_id"
    t.integer "locale_id"
  end

  add_index "wp_events_locale_rel", ["venue_id"], name: "venue_id", using: :btree

  create_table "wp_events_meta", primary_key: "emeta_id", force: true do |t|
    t.integer  "event_id"
    t.string   "meta_key"
    t.text     "meta_value", limit: 2147483647
    t.datetime "date_added"
  end

  add_index "wp_events_meta", ["event_id"], name: "event_id", using: :btree
  add_index "wp_events_meta", ["meta_key"], name: "meta_key", using: :btree

  create_table "wp_events_multi_event_registration_id_group", id: false, force: true do |t|
    t.string "primary_registration_id"
    t.string "registration_id"
  end

  create_table "wp_events_personnel", id: false, force: true do |t|
    t.integer "id",                                   null: false
    t.string  "name",       limit: 250
    t.string  "role",       limit: 250
    t.string  "identifier", limit: 26,  default: "0"
    t.text    "email"
    t.text    "meta"
    t.integer "wp_user",                default: 1
  end

  add_index "wp_events_personnel", ["id"], name: "id", unique: true, using: :btree
  add_index "wp_events_personnel", ["identifier"], name: "identifier", using: :btree
  add_index "wp_events_personnel", ["wp_user"], name: "wp_user", using: :btree

  create_table "wp_events_personnel_rel", force: true do |t|
    t.integer "event_id"
    t.integer "person_id"
  end

  add_index "wp_events_personnel_rel", ["event_id"], name: "event_id", using: :btree
  add_index "wp_events_personnel_rel", ["person_id"], name: "person_id", using: :btree

  create_table "wp_events_prices", force: true do |t|
    t.integer "event_id"
    t.string  "price_type",        limit: 50
    t.decimal "event_cost",                   precision: 20, scale: 2, default: 0.0, null: false
    t.decimal "surcharge",                    precision: 10, scale: 2, default: 0.0, null: false
    t.string  "surcharge_type",    limit: 10
    t.string  "member_price_type", limit: 50
    t.decimal "member_price",                 precision: 20, scale: 2, default: 0.0, null: false
    t.integer "max_qty",                                               default: 0
    t.integer "max_qty_members",                                       default: 0
  end

  add_index "wp_events_prices", ["event_id"], name: "event_id", using: :btree

  create_table "wp_events_qst_group", force: true do |t|
    t.string  "group_name",             limit: 100, default: "NULL", null: false
    t.string  "group_identifier",       limit: 45,  default: "NULL", null: false
    t.text    "group_description"
    t.integer "group_order",                        default: 0
    t.boolean "show_group_name",                    default: true,   null: false
    t.boolean "show_group_description",             default: true,   null: false
    t.boolean "system_group",                       default: false,  null: false
    t.integer "wp_user",                            default: 1
  end

  add_index "wp_events_qst_group", ["system_group"], name: "system_group", using: :btree
  add_index "wp_events_qst_group", ["wp_user"], name: "wp_user", using: :btree

  create_table "wp_events_qst_group_rel", force: true do |t|
    t.integer "group_id",    null: false
    t.integer "question_id", null: false
  end

  add_index "wp_events_qst_group_rel", ["group_id"], name: "group_id", using: :btree
  add_index "wp_events_qst_group_rel", ["question_id"], name: "question_id", using: :btree

  create_table "wp_events_question", force: true do |t|
    t.integer "sequence",                 default: 0,      null: false
    t.string  "question_type", limit: 8,  default: "TEXT", null: false
    t.text    "question",                                  null: false
    t.string  "system_name",   limit: 15
    t.text    "response"
    t.string  "required",      limit: 1,  default: "N",    null: false
    t.text    "required_text"
    t.string  "admin_only",    limit: 1,  default: "N",    null: false
    t.integer "wp_user",                  default: 1
  end

  add_index "wp_events_question", ["admin_only"], name: "admin_only", using: :btree
  add_index "wp_events_question", ["system_name"], name: "system_name", using: :btree
  add_index "wp_events_question", ["wp_user"], name: "wp_user", using: :btree

  create_table "wp_events_seating_chart", force: true do |t|
    t.string "name"
    t.text   "description"
    t.string "image_name"
  end

  create_table "wp_events_seating_chart_event", id: false, force: true do |t|
    t.integer "event_id"
    t.integer "seating_chart_id"
  end

  create_table "wp_events_seating_chart_event_seat", force: true do |t|
    t.integer  "seat_id"
    t.integer  "event_id"
    t.integer  "attendee_id"
    t.float    "purchase_price",    limit: 24
    t.datetime "purchase_datetime"
    t.integer  "by_admin",                     default: 0
    t.integer  "occupied",                     default: 1
  end

  create_table "wp_events_seating_chart_seat", force: true do |t|
    t.integer "seating_chart_id"
    t.string  "level"
    t.string  "section"
    t.string  "row"
    t.string  "seat"
    t.float   "price",            limit: 24
    t.float   "member_price",     limit: 24
    t.text    "custom_tag"
    t.text    "description"
  end

  create_table "wp_events_start_end", force: true do |t|
    t.integer "event_id"
    t.string  "start_time", limit: 10
    t.string  "end_time",   limit: 10
    t.integer "reg_limit",             default: 0
  end

  add_index "wp_events_start_end", ["event_id"], name: "event_id", using: :btree

  create_table "wp_events_venue", id: false, force: true do |t|
    t.integer "id",                                   null: false
    t.string  "name",       limit: 250
    t.string  "identifier", limit: 26,  default: "0"
    t.string  "address",    limit: 250
    t.string  "address2",   limit: 250
    t.string  "city",       limit: 250
    t.string  "state",      limit: 250
    t.string  "zip",        limit: 250
    t.string  "country",    limit: 250
    t.text    "meta"
    t.integer "wp_user",                default: 1
  end

  add_index "wp_events_venue", ["id"], name: "id", unique: true, using: :btree
  add_index "wp_events_venue", ["identifier"], name: "identifier", using: :btree
  add_index "wp_events_venue", ["wp_user"], name: "wp_user", using: :btree

  create_table "wp_events_venue_rel", force: true do |t|
    t.integer "event_id"
    t.integer "venue_id"
  end

  add_index "wp_events_venue_rel", ["event_id"], name: "event_id", using: :btree

  create_table "wp_ibokning_bookings", primary_key: "booking_id", force: true do |t|
    t.string "booking_name",  null: false
    t.string "booking_title", null: false
    t.string "booking_start", null: false
    t.string "booking_end",   null: false
  end

  create_table "wp_links", primary_key: "link_id", force: true do |t|
    t.string   "link_url",                          default: "",  null: false
    t.string   "link_name",                         default: "",  null: false
    t.string   "link_image",                        default: "",  null: false
    t.string   "link_target",      limit: 25,       default: "",  null: false
    t.string   "link_description",                  default: "",  null: false
    t.string   "link_visible",     limit: 20,       default: "Y", null: false
    t.integer  "link_owner",       limit: 8,        default: 1,   null: false
    t.integer  "link_rating",                       default: 0,   null: false
    t.datetime "link_updated",                                    null: false
    t.string   "link_rel",                          default: "",  null: false
    t.text     "link_notes",       limit: 16777215,               null: false
    t.string   "link_rss",                          default: "",  null: false
  end

  add_index "wp_links", ["link_visible"], name: "link_visible", using: :btree

  create_table "wp_ngg_album", force: true do |t|
    t.string  "name",                                      null: false
    t.string  "slug",                                      null: false
    t.integer "previewpic", limit: 8,          default: 0, null: false
    t.text    "albumdesc",  limit: 16777215
    t.text    "sortorder",  limit: 2147483647,             null: false
    t.integer "pageid",     limit: 8,          default: 0, null: false
  end

  create_table "wp_ngg_gallery", primary_key: "gid", force: true do |t|
    t.string  "name",                                    null: false
    t.string  "slug",                                    null: false
    t.text    "path",       limit: 16777215
    t.text    "title",      limit: 16777215
    t.text    "galdesc",    limit: 16777215
    t.integer "pageid",     limit: 8,        default: 0, null: false
    t.integer "previewpic", limit: 8,        default: 0, null: false
    t.integer "author",     limit: 8,        default: 0, null: false
  end

  create_table "wp_ngg_pictures", primary_key: "pid", force: true do |t|
    t.string   "image_slug",                                 null: false
    t.integer  "post_id",     limit: 8,          default: 0, null: false
    t.integer  "galleryid",   limit: 8,          default: 0, null: false
    t.string   "filename",                                   null: false
    t.text     "description", limit: 16777215
    t.text     "alttext",     limit: 16777215
    t.datetime "imagedate",                                  null: false
    t.integer  "exclude",     limit: 1,          default: 0
    t.integer  "sortorder",   limit: 8,          default: 0, null: false
    t.text     "meta_data",   limit: 2147483647
  end

  add_index "wp_ngg_pictures", ["post_id"], name: "post_id", using: :btree

  create_table "wp_options", primary_key: "option_id", force: true do |t|
    t.integer "blog_id",                         default: 0,     null: false
    t.string  "option_name",  limit: 64,         default: "",    null: false
    t.text    "option_value", limit: 2147483647,                 null: false
    t.string  "autoload",     limit: 20,         default: "yes", null: false
  end

  add_index "wp_options", ["option_name"], name: "option_name", unique: true, using: :btree

  create_table "wp_osf_nodes", primary_key: "node_ID", force: true do |t|
    t.string   "node_name",      limit: 55, default: "untitled", null: false
    t.string   "node_type",      limit: 25, default: "file",     null: false
    t.integer  "node_parent_ID", limit: 8,  default: 0,          null: false
    t.string   "node_uri",       limit: 36, default: "",         null: false
    t.string   "node_file_ext",  limit: 36, default: "",         null: false
    t.datetime "created",                                        null: false
    t.datetime "modified",                                       null: false
  end

  add_index "wp_osf_nodes", ["node_parent_ID"], name: "node_parent", using: :btree

  create_table "wp_postmeta", primary_key: "meta_id", force: true do |t|
    t.integer "post_id",    limit: 8,          default: 0, null: false
    t.string  "meta_key"
    t.text    "meta_value", limit: 2147483647
  end

  add_index "wp_postmeta", ["meta_key"], name: "meta_key", using: :btree
  add_index "wp_postmeta", ["post_id"], name: "post_id", using: :btree

  create_table "wp_posts", primary_key: "ID", force: true do |t|
    t.integer  "post_author",           limit: 8,          default: 0,         null: false
    t.datetime "post_date",                                                    null: false
    t.datetime "post_date_gmt",                                                null: false
    t.text     "post_content",          limit: 2147483647,                     null: false
    t.text     "post_title",                                                   null: false
    t.text     "post_excerpt",                                                 null: false
    t.string   "post_status",           limit: 20,         default: "publish", null: false
    t.string   "comment_status",        limit: 20,         default: "open",    null: false
    t.string   "ping_status",           limit: 20,         default: "open",    null: false
    t.string   "post_password",         limit: 20,         default: "",        null: false
    t.string   "post_name",             limit: 200,        default: "",        null: false
    t.text     "to_ping",                                                      null: false
    t.text     "pinged",                                                       null: false
    t.datetime "post_modified",                                                null: false
    t.datetime "post_modified_gmt",                                            null: false
    t.text     "post_content_filtered",                                        null: false
    t.integer  "post_parent",           limit: 8,          default: 0,         null: false
    t.string   "guid",                                     default: "",        null: false
    t.integer  "menu_order",                               default: 0,         null: false
    t.string   "post_type",             limit: 20,         default: "post",    null: false
    t.string   "post_mime_type",        limit: 100,        default: "",        null: false
    t.integer  "comment_count",         limit: 8,          default: 0,         null: false
  end

  add_index "wp_posts", ["post_author"], name: "post_author", using: :btree
  add_index "wp_posts", ["post_name"], name: "post_name", using: :btree
  add_index "wp_posts", ["post_parent"], name: "post_parent", using: :btree
  add_index "wp_posts", ["post_type", "post_status", "post_date", "ID"], name: "type_status_date", using: :btree

  create_table "wp_sp_polls", force: true do |t|
    t.string  "question",   limit: 512, null: false
    t.text    "answers",                null: false
    t.integer "added",                  null: false
    t.integer "active",                 null: false
    t.integer "totalvotes",             null: false
    t.integer "updated",                null: false
  end

  create_table "wp_squashbokning_bookings", primary_key: "booking_id", force: true do |t|
    t.integer "booking_user_id",   null: false
    t.integer "booking_week_slot", null: false
    t.string  "booking_date",      null: false
  end

  create_table "wp_term_relationships", id: false, force: true do |t|
    t.integer "object_id",        limit: 8, default: 0, null: false
    t.integer "term_taxonomy_id", limit: 8, default: 0, null: false
    t.integer "term_order",                 default: 0, null: false
  end

  add_index "wp_term_relationships", ["term_taxonomy_id"], name: "term_taxonomy_id", using: :btree

  create_table "wp_term_taxonomy", primary_key: "term_taxonomy_id", force: true do |t|
    t.integer "term_id",     limit: 8,          default: 0,  null: false
    t.string  "taxonomy",    limit: 32,         default: "", null: false
    t.text    "description", limit: 2147483647,              null: false
    t.integer "parent",      limit: 8,          default: 0,  null: false
    t.integer "count",       limit: 8,          default: 0,  null: false
  end

  add_index "wp_term_taxonomy", ["taxonomy"], name: "taxonomy", using: :btree
  add_index "wp_term_taxonomy", ["term_id", "taxonomy"], name: "term_id_taxonomy", unique: true, using: :btree

  create_table "wp_terms", primary_key: "term_id", force: true do |t|
    t.string  "name",       limit: 200, default: "", null: false
    t.string  "slug",       limit: 200, default: "", null: false
    t.integer "term_group", limit: 8,   default: 0,  null: false
  end

  add_index "wp_terms", ["name"], name: "name", using: :btree
  add_index "wp_terms", ["slug"], name: "slug", unique: true, using: :btree

  create_table "wp_usermeta", primary_key: "umeta_id", force: true do |t|
    t.integer "user_id",    limit: 8,          default: 0, null: false
    t.string  "meta_key"
    t.text    "meta_value", limit: 2147483647
  end

  add_index "wp_usermeta", ["meta_key"], name: "meta_key", using: :btree
  add_index "wp_usermeta", ["user_id"], name: "user_id", using: :btree

  create_table "wp_users", primary_key: "ID", force: true do |t|
    t.string   "user_login",          limit: 60,  default: "", null: false
    t.string   "user_pass",           limit: 64,  default: "", null: false
    t.string   "user_nicename",       limit: 50,  default: "", null: false
    t.string   "user_email",          limit: 100, default: "", null: false
    t.string   "user_url",            limit: 100, default: "", null: false
    t.datetime "user_registered",                              null: false
    t.string   "user_activation_key", limit: 60,  default: "", null: false
    t.integer  "user_status",                     default: 0,  null: false
    t.string   "display_name",        limit: 250, default: "", null: false
  end

  add_index "wp_users", ["user_login"], name: "user_login", unique: true, using: :btree
  add_index "wp_users", ["user_login"], name: "user_login_key", using: :btree
  add_index "wp_users", ["user_nicename"], name: "user_nicename", using: :btree
  add_index "wp_users", ["user_registered"], name: "user_registered", using: :btree

end
