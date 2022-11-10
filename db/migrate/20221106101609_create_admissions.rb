class CreateAdmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :admissions do |t|
      t.string :uid
      t.string :folder_id
      t.string :diagnosis
      t.string :health_facility
      t.date :start_date
      t.date :end_date
      t.text :notes
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
