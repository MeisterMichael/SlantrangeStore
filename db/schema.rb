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

ActiveRecord::Schema.define(version: 20180410192128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "assets", force: :cascade do |t|
    t.string "parent_obj_type"
    t.bigint "parent_obj_id"
    t.bigint "user_id"
    t.string "title"
    t.string "description"
    t.text "content"
    t.string "type"
    t.string "sub_type"
    t.string "use"
    t.string "asset_type", default: "image"
    t.string "origin_name"
    t.string "origin_identifier"
    t.text "origin_url"
    t.text "upload"
    t.integer "height"
    t.integer "width"
    t.integer "duration"
    t.integer "status", default: 1
    t.integer "availability", default: 1
    t.string "tags", default: [], array: true
    t.hstore "properties", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_obj_id", "parent_obj_type", "asset_type", "use"], name: "swell_media_asset_use_index"
    t.index ["parent_obj_type", "parent_obj_id"], name: "index_assets_on_parent_obj_type_and_parent_obj_id"
    t.index ["tags"], name: "index_assets_on_tags", using: :gin
    t.index ["user_id"], name: "index_assets_on_user_id"
  end

  create_table "cart_items", force: :cascade do |t|
    t.bigint "cart_id"
    t.string "item_type"
    t.bigint "item_id"
    t.integer "quantity", default: 1
    t.integer "price", default: 0
    t.integer "subtotal", default: 0
    t.hstore "properties", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
    t.index ["item_type", "item_id"], name: "index_cart_items_on_item_type_and_item_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "order_id"
    t.integer "status", default: 1
    t.integer "subtotal", default: 0
    t.integer "estimated_tax", default: 0
    t.integer "estimated_shipping", default: 0
    t.integer "estimated_total", default: 0
    t.string "ip"
    t.hstore "properties", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.json "checkout_cache", default: {}
    t.index ["order_id"], name: "index_carts_on_order_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "parent_id"
    t.string "name"
    t.string "type"
    t.integer "lft"
    t.integer "rgt"
    t.text "description"
    t.string "avatar"
    t.string "cover_image"
    t.integer "status", default: 1
    t.integer "availability", default: 1
    t.integer "seq"
    t.string "slug"
    t.hstore "properties", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lft"], name: "index_categories_on_lft"
    t.index ["parent_id"], name: "index_categories_on_parent_id"
    t.index ["rgt"], name: "index_categories_on_rgt"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
    t.index ["type"], name: "index_categories_on_type"
    t.index ["user_id"], name: "index_categories_on_user_id"
  end

  create_table "collection_items", force: :cascade do |t|
    t.bigint "collection_id"
    t.string "item_type"
    t.bigint "item_id"
    t.index ["collection_id"], name: "index_collection_items_on_collection_id"
    t.index ["item_type", "item_id"], name: "index_collection_items_on_item_type_and_item_id"
  end

  create_table "collections", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.text "avatar"
    t.integer "status", default: 0
    t.integer "collection_type", default: 1
    t.integer "availability", default: 1
    t.hstore "properties", default: {}
    t.json "query", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status", "availability"], name: "index_collections_on_status_and_availability"
    t.index ["title", "status", "availability"], name: "index_collections_on_title_and_status_and_availability"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "subject"
    t.text "message"
    t.string "type"
    t.string "ip"
    t.string "sub_type"
    t.string "http_referrer"
    t.integer "status", default: 1
    t.hstore "properties", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "code"
    t.index ["email", "type"], name: "index_contacts_on_email_and_type"
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "discount_items", force: :cascade do |t|
    t.bigint "discount_id"
    t.string "applies_to_type"
    t.bigint "applies_to_id"
    t.integer "order_item_type", default: 1
    t.integer "minimum_orders", default: 0
    t.integer "maximum_orders", default: 1
    t.string "currency", default: "USD"
    t.integer "discount_amount"
    t.integer "discount_type", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applies_to_type", "applies_to_id"], name: "index_discount_items_on_applies_to_type_and_applies_to_id"
    t.index ["discount_id"], name: "index_discount_items_on_discount_id"
  end

  create_table "discount_users", force: :cascade do |t|
    t.bigint "discount_id"
    t.bigint "user_id"
    t.index ["discount_id"], name: "index_discount_users_on_discount_id"
    t.index ["user_id"], name: "index_discount_users_on_user_id"
  end

  create_table "discounts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "code"
    t.integer "status", default: 0
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer "availability", default: 1
    t.integer "minimum_prod_subtotal", default: 0
    t.integer "minimum_shipping_subtotal", default: 0
    t.integer "minimum_tax_subtotal", default: 0
    t.integer "limit_per_customer"
    t.integer "limit_global"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "type"
    t.index ["type", "id"], name: "index_discounts_on_type_and_id"
    t.index ["user_id", "status", "code"], name: "index_discounts_on_user_id_and_status_and_code"
    t.index ["user_id", "status", "end_at"], name: "index_discounts_on_user_id_and_status_and_end_at"
    t.index ["user_id", "status", "start_at"], name: "index_discounts_on_user_id_and_status_and_start_at"
    t.index ["user_id", "status", "title"], name: "index_discounts_on_user_id_and_status_and_title"
  end

  create_table "emails", force: :cascade do |t|
    t.string "address"
    t.integer "status", default: 0
    t.string "first_name"
    t.string "last_name"
    t.hstore "properties", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["address", "status"], name: "index_emails_on_address_and_status"
    t.index ["address"], name: "index_emails_on_address", unique: true
    t.index ["status"], name: "index_emails_on_status"
    t.index ["user_id"], name: "index_emails_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "geo_addresses", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "geo_state_id"
    t.bigint "geo_country_id"
    t.integer "status"
    t.string "address_type"
    t.string "title"
    t.string "first_name"
    t.string "last_name"
    t.string "street"
    t.string "street2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.boolean "preferred", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geo_country_id", "geo_state_id"], name: "index_geo_addresses_on_geo_country_id_and_geo_state_id"
    t.index ["geo_country_id"], name: "index_geo_addresses_on_geo_country_id"
    t.index ["geo_state_id"], name: "index_geo_addresses_on_geo_state_id"
    t.index ["user_id"], name: "index_geo_addresses_on_user_id"
  end

  create_table "geo_countries", force: :cascade do |t|
    t.string "name"
    t.string "abbrev"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "bill_to", default: true
    t.boolean "ship_to", default: true
  end

  create_table "geo_states", force: :cascade do |t|
    t.bigint "geo_country_id"
    t.string "name"
    t.string "abbrev"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geo_country_id"], name: "index_geo_states_on_geo_country_id"
  end

  create_table "lead_offer_optins", force: :cascade do |t|
    t.bigint "lead_offer_id"
    t.bigint "optin_id"
    t.integer "status", default: 1
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lead_offer_id", "optin_id"], name: "index_lead_offer_optins_on_lead_offer_id_and_optin_id"
    t.index ["lead_offer_id"], name: "index_lead_offer_optins_on_lead_offer_id"
    t.index ["optin_id"], name: "index_lead_offer_optins_on_optin_id"
  end

  create_table "lead_offers", force: :cascade do |t|
    t.bigint "place_id"
    t.string "title"
    t.string "slug"
    t.string "avatar"
    t.string "cover_image"
    t.text "description"
    t.string "item_name"
    t.string "submit_label"
    t.text "thank_you_msg"
    t.string "email_subject"
    t.text "email_msg"
    t.string "download_url"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id"], name: "index_lead_offers_on_place_id"
    t.index ["slug"], name: "index_lead_offers_on_slug", unique: true
    t.index ["status"], name: "index_lead_offers_on_status"
  end

  create_table "media", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "managed_by_id"
    t.string "public_id"
    t.bigint "category_id"
    t.bigint "avatar_asset_id"
    t.bigint "working_media_version_id"
    t.bigint "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.string "type"
    t.string "sub_type"
    t.string "title"
    t.string "subtitle"
    t.text "avatar"
    t.string "cover_image"
    t.string "avatar_caption"
    t.string "layout"
    t.string "template"
    t.text "description"
    t.text "content"
    t.string "slug"
    t.string "redirect_url"
    t.boolean "is_commentable", default: true
    t.boolean "is_sticky", default: false
    t.boolean "show_title", default: true
    t.datetime "modified_at"
    t.text "keywords", default: [], array: true
    t.string "duration"
    t.integer "cached_char_count", default: 0
    t.integer "cached_word_count", default: 0
    t.integer "status", default: 1
    t.integer "availability", default: 1
    t.datetime "publish_at"
    t.hstore "properties", default: {}
    t.string "tags", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["avatar_asset_id"], name: "index_media_on_avatar_asset_id"
    t.index ["category_id"], name: "index_media_on_category_id"
    t.index ["managed_by_id"], name: "index_media_on_managed_by_id"
    t.index ["parent_id"], name: "index_media_on_parent_id"
    t.index ["public_id"], name: "index_media_on_public_id"
    t.index ["slug", "type"], name: "index_media_on_slug_and_type"
    t.index ["slug"], name: "index_media_on_slug", unique: true
    t.index ["status", "availability"], name: "index_media_on_status_and_availability"
    t.index ["tags"], name: "index_media_on_tags", using: :gin
    t.index ["user_id"], name: "index_media_on_user_id"
    t.index ["working_media_version_id"], name: "index_media_on_working_media_version_id"
  end

  create_table "media_versions", force: :cascade do |t|
    t.bigint "media_id"
    t.bigint "user_id"
    t.integer "status", default: 1
    t.json "versioned_attributes", default: "{}"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_id", "id"], name: "index_media_versions_on_media_id_and_id"
    t.index ["media_id", "status", "id"], name: "index_media_versions_on_media_id_and_status_and_id"
    t.index ["media_id"], name: "index_media_versions_on_media_id"
    t.index ["user_id"], name: "index_media_versions_on_user_id"
  end

  create_table "oauth_credentials", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "refresh_token"
    t.string "secret"
    t.datetime "expires_at"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider"], name: "index_oauth_credentials_on_provider"
    t.index ["secret"], name: "index_oauth_credentials_on_secret"
    t.index ["token"], name: "index_oauth_credentials_on_token"
    t.index ["uid"], name: "index_oauth_credentials_on_uid"
    t.index ["user_id"], name: "index_oauth_credentials_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.string "item_type"
    t.bigint "item_id"
    t.string "title"
    t.integer "quantity", default: 1
    t.integer "price", default: 0
    t.integer "subtotal", default: 0
    t.string "tax_code"
    t.integer "order_item_type", default: 1
    t.hstore "properties", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "subscription_id"
    t.string "sku"
    t.integer "parent_id"
    t.index ["item_id", "item_type", "order_id"], name: "index_order_items_on_item_id_and_item_type_and_order_id"
    t.index ["item_type", "item_id"], name: "index_order_items_on_item_type_and_item_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["order_item_type", "order_id"], name: "index_order_items_on_order_item_type_and_order_id"
    t.index ["subscription_id"], name: "index_order_items_on_subscription_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "billing_address_id"
    t.bigint "shipping_address_id"
    t.string "code"
    t.string "email"
    t.string "ip"
    t.integer "status", default: 2
    t.integer "subtotal", default: 0
    t.integer "tax", default: 0
    t.integer "shipping", default: 0
    t.integer "total"
    t.string "currency", default: "USD"
    t.text "customer_notes"
    t.text "support_notes"
    t.datetime "fulfilled_at"
    t.hstore "properties", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "payment_status", default: 0
    t.integer "fulfillment_status", default: 0
    t.integer "generated_by", default: 1
    t.integer "parent_id"
    t.string "parent_type"
    t.string "provider"
    t.string "provider_customer_profile_reference"
    t.string "provider_customer_payment_profile_reference"
    t.datetime "delivered_at"
    t.integer "discount", default: 0
    t.index ["billing_address_id"], name: "index_orders_on_billing_address_id"
    t.index ["code"], name: "index_orders_on_code", unique: true
    t.index ["email", "billing_address_id", "shipping_address_id"], name: "email_addr_indx"
    t.index ["email", "status"], name: "index_orders_on_email_and_status"
    t.index ["parent_type", "parent_id"], name: "index_orders_on_parent_type_and_parent_id"
    t.index ["shipping_address_id"], name: "index_orders_on_shipping_address_id"
    t.index ["status"], name: "index_orders_on_status"
    t.index ["user_id", "billing_address_id", "shipping_address_id"], name: "user_id_addr_indx"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "product_variants", force: :cascade do |t|
    t.bigint "product_id"
    t.string "title"
    t.string "slug"
    t.string "avatar"
    t.string "option_name", default: "size"
    t.string "option_value"
    t.text "description"
    t.integer "status", default: 1
    t.integer "seq", default: 1
    t.integer "price", default: 0
    t.integer "shipping_price", default: 0
    t.integer "inventory", default: -1
    t.hstore "properties", default: {}
    t.datetime "publish_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "availability", default: 1
    t.integer "package_shape", default: 0
    t.float "package_weight"
    t.float "package_length"
    t.float "package_width"
    t.float "package_height"
    t.index ["option_name", "option_value"], name: "index_product_variants_on_option_name_and_option_value"
    t.index ["product_id"], name: "index_product_variants_on_product_id"
    t.index ["seq"], name: "index_product_variants_on_seq"
    t.index ["slug"], name: "index_product_variants_on_slug", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.bigint "category_id"
    t.text "shopify_code"
    t.string "title"
    t.string "caption"
    t.integer "seq", default: 1
    t.string "slug"
    t.string "avatar"
    t.string "brand_model"
    t.integer "status", default: 0
    t.text "description"
    t.text "content"
    t.datetime "publish_at"
    t.integer "price", default: 0
    t.integer "suggested_price", default: 0
    t.integer "shipping_price", default: 0
    t.string "currency", default: "USD"
    t.string "tags", default: [], array: true
    t.hstore "properties", default: {}
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "brand"
    t.string "model"
    t.text "size_info"
    t.text "notes"
    t.integer "collection_id"
    t.string "tax_code", default: "00000"
    t.integer "availability", default: 1
    t.integer "package_shape", default: 0
    t.float "package_weight"
    t.float "package_length"
    t.float "package_width"
    t.float "package_height"
    t.text "cart_description"
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["seq"], name: "index_products_on_seq"
    t.index ["slug"], name: "index_products_on_slug", unique: true
    t.index ["status"], name: "index_products_on_status"
    t.index ["tags"], name: "index_products_on_tags", using: :gin
  end

  create_table "shipping_carrier_services", force: :cascade do |t|
    t.bigint "shipping_option_id"
    t.string "name"
    t.string "description"
    t.string "carrier"
    t.string "service_code"
    t.string "service_name"
    t.string "service_group"
    t.string "service_description"
    t.string "delivery_category"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shipping_option_id"], name: "index_shipping_carrier_services_on_shipping_option_id"
  end

  create_table "shipping_options", force: :cascade do |t|
    t.string "name"
    t.string "short_description"
    t.string "description"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subscription_plans", force: :cascade do |t|
    t.string "billing_interval_unit", default: "months"
    t.integer "billing_interval_value", default: 1
    t.string "billing_statement_descriptor"
    t.integer "trial_price", default: 0
    t.string "trial_interval_unit", default: "month"
    t.integer "trial_interval_value", default: 1
    t.integer "trial_max_intervals", default: 0
    t.string "trial_statement_descriptor"
    t.integer "subscription_plan_type", default: 1
    t.string "title"
    t.integer "seq", default: 1
    t.string "slug"
    t.string "avatar"
    t.integer "status", default: 0
    t.text "description"
    t.text "content"
    t.datetime "publish_at"
    t.integer "price", default: 0
    t.integer "shipping_price", default: 0
    t.string "currency", default: "USD"
    t.hstore "properties", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tax_code", default: "00000"
    t.string "product_sku"
    t.string "trial_sku"
    t.integer "availability", default: 1
    t.integer "package_shape", default: 0
    t.float "package_weight"
    t.float "package_length"
    t.float "package_width"
    t.float "package_height"
    t.integer "item_id"
    t.string "item_type"
    t.text "cart_description"
    t.index ["slug"], name: "index_subscription_plans_on_slug", unique: true
    t.index ["status"], name: "index_subscription_plans_on_status"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "subscription_plan_id"
    t.bigint "billing_address_id"
    t.bigint "shipping_address_id"
    t.integer "quantity", default: 1
    t.string "code"
    t.integer "status", default: 0
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "canceled_at"
    t.datetime "trial_start_at"
    t.datetime "trial_end_at"
    t.datetime "current_period_start_at"
    t.datetime "current_period_end_at"
    t.datetime "next_charged_at"
    t.integer "amount"
    t.integer "trial_amount"
    t.string "currency", default: "USD"
    t.string "provider"
    t.string "provider_reference"
    t.string "provider_customer_profile_reference"
    t.string "provider_customer_payment_profile_reference"
    t.datetime "payment_profile_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "discount_id"
    t.integer "billing_interval_value", default: 1
    t.string "billing_interval_unit", default: "months"
    t.integer "trial_price"
    t.integer "price"
    t.datetime "failed_at"
    t.text "failed_message"
    t.integer "failed_attempts", default: 0
    t.index ["billing_address_id"], name: "index_subscriptions_on_billing_address_id"
    t.index ["shipping_address_id"], name: "index_subscriptions_on_shipping_address_id"
    t.index ["subscription_plan_id"], name: "index_subscriptions_on_subscription_plan_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "parent_obj_type"
    t.bigint "parent_obj_id"
    t.integer "transaction_type", default: 1
    t.string "provider"
    t.string "reference_code"
    t.string "customer_profile_reference"
    t.string "customer_payment_profile_reference"
    t.integer "amount", default: 0
    t.string "currency", default: "USD"
    t.integer "status", default: 1
    t.text "message"
    t.hstore "properties", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_obj_type", "parent_obj_id"], name: "index_transactions_on_parent_obj_type_and_parent_obj_id"
    t.index ["reference_code"], name: "index_transactions_on_reference_code"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "slug"
    t.string "first_name"
    t.string "last_name"
    t.string "avatar"
    t.string "cover_image"
    t.datetime "dob"
    t.string "gender"
    t.string "location"
    t.string "address1"
    t.string "address2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone"
    t.integer "status", default: 1
    t.integer "role", default: 1
    t.integer "level", default: 1
    t.string "website_url"
    t.text "bio"
    t.string "short_bio"
    t.text "sig"
    t.string "ip"
    t.float "latitude"
    t.float "longitude"
    t.string "timezone", default: "Pacific Time (US & Canada)"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "password_hint"
    t.string "password_hint_response"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "authentication_token"
    t.hstore "properties", default: {}
    t.hstore "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tags", default: [], array: true
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["name"], name: "index_users_on_name"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end
