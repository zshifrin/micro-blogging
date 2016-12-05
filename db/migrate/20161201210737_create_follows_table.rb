class CreateFollowsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :follows do |t|
    	t.integer :user_id
    	t.integer :target_id
    	t.timestamps
    end
    add_foreign_key :follows, :users, on_delete: :cascade
    add_foreign_key :follows, :users, column: :target_id, primary_key: :id, on_delete: :cascade
    add_index :follows, [:user_id, :target_id], unique: true
  end
end
