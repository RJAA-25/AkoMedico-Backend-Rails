class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.string :file_id
      t.string :image_link
      t.string :download_link
      t.references :result_issue, polymorphic: true, null: false

      t.timestamps
    end
  end
end
