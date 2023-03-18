class CreateEmergencyContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :emergency_contacts do |t|
      t.string :full_name
      t.string :relationship
      t.string :contact_number
      t.string :uid
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
