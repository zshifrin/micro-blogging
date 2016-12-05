get '/mockups' do
	erb :"mockups/index"
end

get '/mockups/register' do
	erb :"mockups/register"
end

get '/mockups/profile-unfollow' do
	erb :"mockups/profile-unfollow"
end

get '/mockups/home-logged-in' do
	session[:user_id] = 1
	erb :"mockups/home"
end

get '/mockups/home-logged-out' do
	session[:user_id] = nil
	erb :"mockups/home"
end

get '/mockups/login' do
	erb :"mockups/login"
end

get '/mockups/profile' do
	erb :"mockups/profile"
end

get '/mockups/edit-account' do
	erb :"mockups/edit-account"
end
