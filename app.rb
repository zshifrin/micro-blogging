require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'bundler/setup'
require './helpers'
require './models'
require './hasher'

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
  @posts = current_user ? current_users.posts : Post.take(10)
  erb :index
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
	erb :"accounts/edit"
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
  #unfollows target
end

delete '/accounts/:id' do
	#deletes account :id
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

























