class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.boolean :email_confirmed

      t.timestamps
    end
  end
end
