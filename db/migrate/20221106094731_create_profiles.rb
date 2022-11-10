class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.date :birth_date
      t.string :address
      t.string :nationality
      t.string :civil_status
      t.string :contact_number
      t.decimal :height, precision: 3, scale: 2
      t.decimal :weight, precision: 4, scale: 1
      t.string :sex
      t.string :blood_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
