class User < ActiveRecord::Base
	  has_many :posts
	  has_many :follows
end

class Follow < ActiveRecord::Base
	belongs_to :user_id, :class_name => 'User', :foreign_key => 'user_id'
	belongs_to :target_id, :class_name => 'User', :foreign_key => 'target_id'
end

class Post < ActiveRecord::Base
	belongs_to :user
end