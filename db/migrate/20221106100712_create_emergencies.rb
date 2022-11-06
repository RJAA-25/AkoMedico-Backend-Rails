class CreateEmergencies < ActiveRecord::Migration[7.0]
  def change
    create_table :emergencies do |t|
      t.string :full_name
      t.string :relationship
      t.string :contact_number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
