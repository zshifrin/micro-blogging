# app.rb
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'bundler/setup'
require './models'

enable :sessions

set :sessions, true
set :database, "sqlite3:pygmy.sqlite3"

get '/' do
  erb :index
end

post '/users' do
  User.create({
    username: params[:username],
    email: params[:email],
    password: params[:password]
    # more fields ...
  })

  redirect '/'
end
