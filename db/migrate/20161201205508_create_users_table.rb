class CreateUsersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.text :bio, limit: 4294967295, default: '', null: true
      t.string :password, null: false
      t.string :photo
      t.timestamps
    end
    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end