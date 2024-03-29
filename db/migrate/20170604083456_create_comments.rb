class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :sender_id
      t.integer :receiver_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
