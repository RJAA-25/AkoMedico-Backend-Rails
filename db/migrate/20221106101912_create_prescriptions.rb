class CreatePrescriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :prescriptions do |t|
      t.string :uid
      t.string :image_url
      t.references :prescription_issue, polymorphic: true, null: false

      t.timestamps
    end
  end
end
