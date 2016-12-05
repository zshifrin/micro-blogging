class CreatePostsTable < ActiveRecord::Migration[5.0]
  def change
  	create_table :posts do |t|
  		t.text :content, limit: 4294967295, null: false
  		t.integer :user_id
  		t.timestamps
  	end
  	add_foreign_key :posts, :users, on_delete: :cascade
  end
end
