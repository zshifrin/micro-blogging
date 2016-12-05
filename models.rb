require './helpers'

class User < ActiveRecord::Base
  has_many :posts

  has_many :passive_relationships, class_name: 'Follow', foreign_key: 'target_id'
  has_many :active_relationships, class_name: 'Follow', foreign_key: 'user_id'

  has_many :followers, through: :passive_relationships, source: :follower
  has_many :following, through: :active_relationships,  source: :target

  def follow(target)
    Follow.create(user_id: id, target_id: target.id)
  end

  def unfollow(target)
    Follow.where(user_id: id, target_id: target.id).destroy
  end
end

class Follow < ActiveRecord::Base
  belongs_to :follower, class_name: 'User', foreign_key: 'user_id'
  belongs_to :target, class_name: 'User', foreign_key: 'target_id'
end

class Post < ActiveRecord::Base
  belongs_to :user
end