require_relative '../hasher'
require_relative '../helpers'

LOREM = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
TABLES = ['users', 'posts', 'follows']

def truncate_tables
  ActiveRecord::Base.connection.execute('SET foreign_key_checks = 0')
  TABLES.each do |t|
    ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{t}")
  end
  ActiveRecord::Base.connection.execute("SET foreign_key_checks = 1")
end

def random_user_id
  User.last.id + 1 - rand(1..User.count)
end

def create_follow
    user_id = random_user_id
    target_id = random_user_id

    return create_follow if user_id == target_id
    return create_follow unless Follow.where(user_id: user_id, target_id: target_id).empty?

    Follow.create({user_id: user_id, target_id: target_id})
end

# Truncate all tables (empty and set primary key back auto increment to 0)
truncate_tables

users = [
	{username: 'pygmyfan', name: 'Bob Barker', email: 'bbarker@gmail.com', bio: LOREM, password: Hasher.make('priceisright'), photo: 'placeholder.png'},
	{username: 'priceiswrong', name: 'Cindy Barker', email: 'cbarker@gmail.com', bio: LOREM, password: Hasher.make('priceisright'), photo: 'placeholder.png'},
	{username: 'pygmy', name: 'Billy Barker', email: 'billybarker@gmail.com', bio: LOREM, password: Hasher.make('priceisright'), photo: 'placeholder.png'},
	{username: 'pygmygoat', name: 'Brenda Barker', email: 'brendabarker@gmail.com', bio: LOREM, password: Hasher.make('priceisright'), photo: 'placeholder.png'},
	{username: 'pygmyguy', name: 'Ben Barker', email: 'benbarker@gmail.com', bio: LOREM, password: Hasher.make('priceisright'), photo: 'placeholder.png'},
	{username: 'pygmylady', name: 'Bran Barker', email: 'branbarker@gmail.com', bio: LOREM, password: Hasher.make('priceisright'), photo: 'placeholder.png'},
	{username: 'pygmyuser', name: 'Bo Barker', email: 'bobarker@gmail.com', bio: LOREM, password: Hasher.make('priceisright'), photo: 'placeholder.png'}
]

users.each do |user|
  User.create(user)
end

100.times do |i|
  content = "Example Pygmy #{i}"
  u = Post.create({content: content, user_id: random_user_id})
end

20.times do |i|
  create_follow
end
