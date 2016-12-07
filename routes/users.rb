#
# SHOW EDIT USER FORM
#
get '/users/:id/edit' do
  # shows form for editing account
  @user = User.find(params[:id])
  erb :"users/edit"
end

#
# POST EDIT USER FORM
#
post '/users/:id/edit' do
  user = User.find(params[:id])

  user.username = params[:username]
  user.email = params[:email]
  user.bio = params[:bio]

  is_setting_password = !params[:new_password].empty? && !params[:current_password].empty?
  password_confirms = user.password == Hasher.make(params[:current_password]) && params[:new_password] == params[:confirm_password]

  if is_setting_password && password_confirms
    user.password = Hasher.make(params[:new_password])
  end

  user.save
end

#
# SHOW USER PROFILE
#
get '/profiles/:username' do

  @user = User.where(username: params[:username]).first
  @posts = @user.posts.order(created_at: :desc)

  if @user.nil?
    status(404)
    erb :oops
  else
    erb :profile
  end
end

#
# CREATE USER
#
post '/users' do
  u = User.create({
    username: params[:username],
    email: params[:email],
    password: Hasher.make(params[:password]),
    name: params[:name],
    bio: params[:bio],
    photo: params[:photo]
  })

  session[:user_id] = u.id

  redirect '/'
end

#
# DELETE USER
#
delete '/users/:id' do

  if session[:user_id] != params[:id]
    status(404)
    erb :oops
  end

  puts "Param: #{params[:id]}"
  puts "USER: #{current_user.id}"

  User.find(params[:id]).destroy
  session[:user_id] = nil
  redirect '/register'
end