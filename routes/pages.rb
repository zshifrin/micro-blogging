#
# HOME
#
get '/' do
  # if user is logged, show the posts of they people they are following
  # else show latest 10 posts of any user

  # Needs updated (not showing posts of followers)
  @posts = Post.take(10)
  erb :index
end

#
# SHOW LOGIN
#
get '/login' do
  erb :login
end

#
# POST LOGIN
#
post '/login' do
  query = 'SELECT * FROM users WHERE username = :field OR email = :field'
  @user = User.find_by_sql([query, {field: params[:sign_in_field]}]).first

  if @user && Hasher.verify(@user, params[:password])
    session[:user_id] = @user.id
    flash[:notice] = "You've been signed in successfully."
    redirect '/'
  else
    flash[:error] = 'There was a problem signing you in.'
    redirect '/login'
  end
end

#
# GET LOGOUT
#
get '/logout' do
  session[:user_id] = nil
end

#
# SHOW REGISTER
#
get '/register' do
  erb :register
end

#
# POST REGISTER
#
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