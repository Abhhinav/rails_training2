class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :title
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.integer :post_id
      t.integer :replyto_user_id

      t.timestamps
    end
  end
end
