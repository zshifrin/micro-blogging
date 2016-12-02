def create_follow(record)
    random_user_id = User.last.id + 1 - rand(1..User.count)
    random_target_id = User.last.id + 1 - rand(1..User.count)

  	if Follow.where(user_id: random_user_id, target_id: random_target_id).empty?
      record[:user_id] = random_user_id
      record[:target_id] = random_target_id
      Follow.create(record)
    else
    	create_follow(record)
    end
end

lorem = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

users = [
	{username: 'pygmyfan', name: 'Bob Barker', email: 'bbarker@gmail.com', bio: lorem, password: 'priceright', photo: 'placeholder.png'},
	{username: 'priceiswrong', name: 'Cindy Barker', email: 'cbarker@gmail.com', bio: lorem, password: 'priceright', photo: 'placeholder.png'},
	{username: 'pygmy', name: 'Billy Barker', email: 'billybarker@gmail.com', bio: lorem, password: 'priceright', photo: 'placeholder.png'},
	{username: 'pygmygoat', name: 'Brenda Barker', email: 'brendabarker@gmail.com', bio: lorem, password: 'priceright', photo: 'placeholder.png'},
	{username: 'pygmyguy', name: 'Ben Barker', email: 'benbarker@gmail.com', bio: lorem, password: 'priceright', photo: 'placeholder.png'},
	{username: 'pygmylady', name: 'Bran Barker', email: 'branbarker@gmail.com', bio: lorem, password: 'priceright', photo: 'placeholder.png'},
	{username: 'pygmyuser', name: 'Bo Barker', email: 'bobarker@gmail.com', bio: lorem, password: 'priceright', photo: 'placeholder.png'}
]

posts = [
	{content: lorem, user_id: nil}, 
	{content: lorem, user_id: nil}, 
	{content: lorem, user_id: nil}, 
	{content: lorem, user_id: nil}, 
	{content: lorem, user_id: nil},
	{content: lorem, user_id: nil},
	{content: lorem, user_id: nil}, 
	{content: lorem, user_id: nil}, 
	{content: lorem, user_id: nil}, 
	{content: lorem, user_id: nil}, 
	{content: lorem, user_id: nil},
	{content: lorem, user_id: nil},
	{content: lorem, user_id: nil}
]

follows = [
	{user_id: nil, target_id: nil},
	{user_id: nil, target_id: nil},
	{user_id: nil, target_id: nil},
	{user_id: nil, target_id: nil},
	{user_id: nil, target_id: nil},
	{user_id: nil, target_id: nil}
]

models = ['Users', 'Posts', 'Follows']

models.each do |m|
  model = eval(m.chomp('s')) # User | Post | Comment
  model.destroy_all

  collection = eval(m.downcase)

  collection.each do |record| # users.each | posts.each
    if record.key?(:post_id) == true
      record[:post_id] = Post.last.id + 1 - rand(1..Post.count)
    end

    if 'follows' === m.downcase
    	create_follow(record)
    	next
    else
	    if record.key?(:user_id)
	      record[:user_id] = User.last.id + 1 - rand(1..User.count)
	    end
	  end

    model.create(record)
  end
end



