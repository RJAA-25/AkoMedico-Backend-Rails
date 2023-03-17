class CreateConsultations < ActiveRecord::Migration[7.0]
  def change
    create_table :consultations do |t|
      t.string :uid
      t.string :diagnosis
      t.string :health_facility
      t.date :schedule
      t.text :notes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
