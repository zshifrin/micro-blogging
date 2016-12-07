#
# CREATE POST
#
post '/posts' do
  Post.create({
    content: params[:content],
    user_id: current_user.id
  })

  redirect "profiles/#{current_user.username}"
end

#
# DELETE POST
#
delete '/posts/:id' do
	Post.find(params[:id]).destroy
	redirect back
end

#
# UPDATE POST
#
put '/posts/:id' do
  # update post :id
end