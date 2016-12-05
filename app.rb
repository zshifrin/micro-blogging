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

post '/login' do
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
	@user = User.where(username: params[:username]).first

	if @user.nil?
		status(404)
		erb :oops
	else
		erb :profile
	end

end

get '/accounts/:id/edit'
	#shows form for editing account
	@user 
	erb :"accounts/edit"
end

post '/posts' do
	#store post in db
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





























