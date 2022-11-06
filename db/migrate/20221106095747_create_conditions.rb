class CreateConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :conditions do |t|
      t.string :diagnosis
      t.date :start
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
