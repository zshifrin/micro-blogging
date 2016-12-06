#
# CREATE FOLLOW
#
post '/users/:id/follow' do
  target = User.find(params[:id])

  if target.nil?
    status(404)
    erb :oops
  else
    # Follow.create(user_id: current_user.id, params[:id])
  end
end

#
# DELETE FOLLOW
#
delete '/users/:id/follow' do
  Follow.where(user_id: current_user.id, target_id: params[:id]).first.destroy
  redirect '/'
end