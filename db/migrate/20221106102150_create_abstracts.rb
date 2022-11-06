class CreateAbstracts < ActiveRecord::Migration[7.0]
  def change
    create_table :abstracts do |t|
      t.string :file_id
      t.string :image_link
      t.string :download_link
      t.references :admission, null: false, foreign_key: true

      t.timestamps
    end
  end
end
