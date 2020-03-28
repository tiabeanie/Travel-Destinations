class UsersController < ApplicationController
  register Sinatra::Flash
  require 'sinatra/flash'
  enable :sessions

  get '/users/:id' do
    if !logged_in?
        redirect '/destinations'
    end 

    @user = User.find(params[:id])
    if !@user.nil? && @user == current_user
        erb :'users/show'
    else
        redirect '/destinations'
    end 
end 

  get '/signup' do
    if !session[:user_id]
      erb :'users/signup'
    else
      redirect to '/destinations'
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/destinations'
    end
  end

  get '/login' do 
    @error_message = params[:error]
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/destinations'
    end
  end

  post "/login" do
      user = User.find_by(:email => params[:email])
      if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect "/destinations"
      else
          redirect to '/signup'
      end
  end

  get "/logout" do
      if session[:user_id] != nil
          session.destroy
          redirect '/login' 
      else
          redirect to "/"
      end
  end
end