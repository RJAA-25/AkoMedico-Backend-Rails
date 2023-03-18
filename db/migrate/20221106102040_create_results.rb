class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.string :uid
      t.string :image_url
      t.references :result_issue, polymorphic: true, null: false

      t.timestamps
    end
  end
end
