# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_29_164117) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "allergens", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "allergies", force: :cascade do |t|
    t.date "detected_on"
    t.string "severity"
    t.text "reactions"
    t.text "comments"
    t.bigint "pet_id", null: false
    t.bigint "allergen_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["allergen_id"], name: "index_allergies_on_allergen_id"
    t.index ["pet_id"], name: "index_allergies_on_pet_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "datetime"
    t.string "reason"
    t.string "comments"
    t.float "fee"
    t.bigint "pet_id", null: false
    t.bigint "service_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status"
    t.index ["pet_id"], name: "index_appointments_on_pet_id"
    t.index ["service_id"], name: "index_appointments_on_service_id"
  end

  create_table "conditions", force: :cascade do |t|
    t.date "diagnosis_date"
    t.date "recovery_date"
    t.string "comments"
    t.bigint "pet_id", null: false
    t.bigint "disease_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["disease_id"], name: "index_conditions_on_disease_id"
    t.index ["pet_id"], name: "index_conditions_on_pet_id"
  end

  create_table "diseases", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nutritions", force: :cascade do |t|
    t.date "date"
    t.string "meal_type"
    t.string "food_items"
    t.integer "calories"
    t.text "notes"
    t.boolean "completed"
    t.bigint "pet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_nutritions_on_pet_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.string "pet_type"
    t.string "breed"
    t.date "birthday_date"
    t.string "gender"
    t.integer "weight"
    t.integer "height"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.index ["user_id"], name: "index_pets_on_user_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "description"
    t.float "fee"
    t.bigint "veterinary_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["veterinary_id"], name: "index_services_on_veterinary_id"
  end

  create_table "trainings", force: :cascade do |t|
    t.date "date"
    t.string "title"
    t.text "description"
    t.integer "duration"
    t.integer "calories_burned"
    t.boolean "completed"
    t.bigint "pet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_trainings_on_pet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vaccinations", force: :cascade do |t|
    t.date "date"
    t.string "comments"
    t.bigint "pet_id", null: false
    t.bigint "vaccine_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["pet_id"], name: "index_vaccinations_on_pet_id"
    t.index ["vaccine_id"], name: "index_vaccinations_on_vaccine_id"
  end

  create_table "vaccines", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "veterinaries", force: :cascade do |t|
    t.string "dni"
    t.string "specialization"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_veterinaries_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "allergies", "allergens"
  add_foreign_key "allergies", "pets"
  add_foreign_key "appointments", "pets"
  add_foreign_key "appointments", "services"
  add_foreign_key "conditions", "diseases"
  add_foreign_key "conditions", "pets"
  add_foreign_key "nutritions", "pets"
  add_foreign_key "pets", "users"
  add_foreign_key "services", "veterinaries"
  add_foreign_key "trainings", "pets"
  add_foreign_key "vaccinations", "pets"
  add_foreign_key "vaccinations", "vaccines"
  add_foreign_key "veterinaries", "users"
end
