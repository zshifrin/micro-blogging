#
# CREATE POST
#
post '/posts' do
  Post.create({
    content: params[:content],
    user_id: current_user.id
  })

  redirect "/#{current_user.username}"
end

#
# DELETE POST
#
delete '/posts/:id' do
  # delete post :id
end

#
# UPDATE POST
#
put '/posts/:id' do
  # update post :id
end