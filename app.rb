require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'bundler/setup'
require './models'
require './hasher'

enable :sessions

set :sessions, true
set :database, "sqlite3:pygmy.sqlite3"

def current_user
  if session[:user_id]
  	@current_user = User.find(session[:user_id])
  end
end

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

post '/sign-in' do
  @user = User.find_by_sql(['SELECT * FROM users WHERE username = ? OR email = ?', params[:sign_in_field], params[:sign_in_field]]).first

  if @user && @user.password == Hasher.make(params[:password])
    session[:user_id] = @user.id
    flash[:notice] = "You've been signed in successfully."
  else
    flash[:error] = "There was a problem signing you in."
  end
  redirect "/"
end

get '/:username' do
	puts params[:username]
	# @posts = current_user 
end
