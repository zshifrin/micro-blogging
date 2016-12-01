# app.rb
require 'sinatra'
require 'sinatra/activerecord'
require './models'
require 'bundler/setup'
require 'sinatra/flash'

enable :sessions

set :sessions, true
set :database, "sqlite3:project-name.sqlite3"