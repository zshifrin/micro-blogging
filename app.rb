require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'bundler/setup'
require './helpers'
require './models'
require './hasher'
require './mockup_routes'

enable :sessions
set :sessions, true

db_username = 'root'
db_password = 'root'
db_host = '127.0.0.1'
db_port = 3306
db_database = 'micro_blog'

set :database, "mysql2://#{db_username}:#{db_password}@#{db_host}:#{db_port}/#{db_database}"
# set :database, "sqlite3:pygmy.sqlite3"

get '/' do
  # if user is logged, show their posts
  # else show latest 10 posts of any user
  @posts = current_user ? current_user.posts : Post.take(10)
  erb :index
end

get '/register' do
  erb :register  
end

post '/register' do
  
  u = User.create({
      name: params[:name],
      username: params[:username],
      password: Hasher.make(params[:password]),
      email: params[:email],
      bio: params[:bio]
  })

  session[:user_id] = u.id

  redirect '/'
end

post '/users' do
  User.create({
    username: params[:username],
    email: params[:email],
    password: Hasher.make(params[:password]),
    name: params[:name],
    bio: params[:bio],
    photo: params[:photo]
  })
  redirect '/'
end

post '/login' do
  query = 'SELECT * FROM users WHERE username = :field OR email = :field'
  @user = User.find_by_sql([query, {field: params[:sign_in_field]}]).first

  if @user && @user.password == Hasher.make(params[:password])
    session[:user_id] = @user.id
    flash[:notice] = "You've been signed in successfully."
  else
    flash[:error] = "There was a problem signing you in."
  end
  redirect '/'
end

get '/accounts/:id/edit' do
	# shows form for editing account
  @user = User.find(params[:id])
	erb :"accounts/edit"
end

post '/accounts/:id/edit' do
  @user = User.find(params[:id])
  @user.username = params[:username]
  @user.email = params[:email]
  @user.bio = params[:bio]
  # set all other properties
  # have conditionals optional properties
  puts params.inspect

  # current && new match,then Hasher.make(new_password_value)
  is_setting_password = !params[:new_password].empty? && !params[:current_password].empty?
  password_confirms = @user.password == Hasher.make(params[:current_password]) && params[:new_password] == params[:confirm_password]
  if is_setting_password && password_confirms
    @user.password = Hasher.make(params[:new_password])
  end
  #if current password and new password are not empty and new password matches confirm password set user.password equal new password
  @user.save
end

# post '/posts', auth: true do
post '/posts' do
  Post.create({
    content: params[:content],
    user_id: current_user.id
  })

  redirect '/profiles'
end

delete '/posts/:id' do
	#delete post :id
end

put '/posts/:id' do
	#update post :id
end

post '/users/:id/follow' do
#follows target
end

delete '/users/:id/follow' do
  target = User.find(params[:id])
  Follow.where(user_id: current_user.id, target_id: target.id).first.destroy
  redirect '/'
end

delete '/users/:id' do
  User.find(params[:id]).destroy
  redirect '/register'
end

get '/login' do
  erb :login
end

get '/:username' do
  @user = User.where(username: params[:username]).first

  if @user.nil?
    status(404)
    erb :oops
  else
    erb :profile
  end
end























