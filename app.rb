require 'pry'
require 'sinatra'
require 'sinatra/reloader'
require "better_errors"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

# this will store your users
users = [

]

# this will store an id to user for your users
# you'll need to increment it every time you add
# a new user, but don't decrement it
id = 1

# routes to implement:
#
# GET / - show all users
get '/' do
  @users = users
  erb :index
end

# GET /users/new - display a form for making a new user
get '/users/new' do
  erb :new
end
#
# POST /users - create a user based on params from form

post '/users' do
  users.push({ first: params[:first_name], last: params[:last_name], id: id })
  id +=1
  redirect to('/') #telling the browser to go back to the page when you're making a post
end
#
#
# GET /users/:id - show a user's info by their id, this should display the info in a form
get '/users/:id' do
  @user = users.find{|user| user[:id] == params[:id].to_i}
  erb :show
end
#
# PUT /users/:id - update a user's info based on the form from GET /users/:id
put '/users/:id' do
  user = users.find{|user| user[:id] == params[:id].to_i}
  user[:first] = params[:first_name]
  user[:last] = params[:last_name]
  redirect to('/')
end

#
# DELETE /users/:id - delete a user by their id
delete '/users/:id' do
  user = users.find{|user| user[:id] == params[:id].to_i}
  users.delete(user)
  redirect to('/')

end
