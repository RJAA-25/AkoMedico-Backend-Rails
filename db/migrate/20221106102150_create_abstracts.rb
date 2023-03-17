class CreateAbstracts < ActiveRecord::Migration[7.0]
  def change
    create_table :abstracts do |t|
      t.string :uid
      t.string :image_url
      t.references :admission, null: false, foreign_key: true

      t.timestamps
    end
  end
end
