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

ActiveRecord::Schema[7.0].define(version: 2022_11_08_073935) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abstracts", force: :cascade do |t|
    t.string "uid"
    t.string "image_url"
    t.bigint "admission_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admission_id"], name: "index_abstracts_on_admission_id"
  end

  create_table "admissions", force: :cascade do |t|
    t.string "uid"
    t.string "diagnosis"
    t.string "health_facility"
    t.date "start_date"
    t.date "end_date"
    t.text "notes"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_admissions_on_user_id"
  end

  create_table "admissions_doctors", id: false, force: :cascade do |t|
    t.bigint "admission_id", null: false
    t.bigint "doctor_id", null: false
  end

  create_table "conditions", force: :cascade do |t|
    t.string "diagnosis"
    t.date "start_date"
    t.date "end_date"
    t.string "uid"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_conditions_on_user_id"
  end

  create_table "consultations", force: :cascade do |t|
    t.string "uid"
    t.string "diagnosis"
    t.string "health_facility"
    t.date "schedule"
    t.text "notes"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_consultations_on_user_id"
  end

  create_table "consultations_doctors", id: false, force: :cascade do |t|
    t.bigint "consultation_id", null: false
    t.bigint "doctor_id", null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "specialty"
    t.string "uid"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_doctors_on_user_id"
  end

  create_table "emergency_contacts", force: :cascade do |t|
    t.string "full_name"
    t.string "relationship"
    t.string "contact_number"
    t.string "uid"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_emergency_contacts_on_user_id"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.string "uid"
    t.string "image_url"
    t.string "prescription_issue_type", null: false
    t.bigint "prescription_issue_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prescription_issue_type", "prescription_issue_id"], name: "index_prescriptions_on_prescription_issue"
  end

  create_table "profiles", force: :cascade do |t|
    t.date "birth_date"
    t.string "address"
    t.string "nationality"
    t.string "civil_status"
    t.string "contact_number"
    t.decimal "height", precision: 3, scale: 2
    t.decimal "weight", precision: 4, scale: 1
    t.string "sex"
    t.string "blood_type"
    t.string "uid"
    t.string "image_url"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "results", force: :cascade do |t|
    t.string "uid"
    t.string "image_url"
    t.string "result_issue_type", null: false
    t.bigint "result_issue_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["result_issue_type", "result_issue_id"], name: "index_results_on_result_issue"
  end

  create_table "users", force: :cascade do |t|
    t.string "uid"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "password_digest"
    t.boolean "email_confirmed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "abstracts", "admissions"
  add_foreign_key "admissions", "users"
  add_foreign_key "conditions", "users"
  add_foreign_key "consultations", "users"
  add_foreign_key "doctors", "users"
  add_foreign_key "emergency_contacts", "users"
  add_foreign_key "profiles", "users"
end
