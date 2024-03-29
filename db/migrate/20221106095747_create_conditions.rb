class CreateConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :conditions do |t|
      t.string :diagnosis
      t.date :start_date
      t.date :end_date
      t.string :uid
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
