require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'bundler/setup'
require './helpers'
require './models'
require './hasher'
require './mockup_routes'
require './routes/pages'
require './routes/users'
require './routes/posts'
require './routes/follows'

enable :sessions

db_username = 'root'
db_password = 'root'
db_host = '127.0.0.1'
db_port = 3306
db_database = 'micro_blog'

set :database, "mysql2://#{db_username}:#{db_password}@#{db_host}:#{db_port}/#{db_database}"
# set :database, "sqlite3:pygmy.sqlite3"

























