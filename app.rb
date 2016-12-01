# app.rb
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'bundler/setup'
require './models'

enable :sessions

set :sessions, true
set :database, "sqlite3:pygmy.sqlite3"

