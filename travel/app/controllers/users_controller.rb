class UsersController < ApplicationController
  
  get '/signup' do
    redirect to '/destinations' if logged_in?
    erb :"users/signup"
  end

  post '/signup' do
    user_info = { :name => params["name"],
                  :email => params["email"],
                  :password => params["password"] }

    if User.find_by(:email => user_info[:email])
      redirect "/users/signup?error=this email address is already in our system"
    end
    new_user = User.create(user_info)
    session[:user_id] = new_user.id
    redirect to '/destinations'
  end

  get '/login' do
    redirect to '/destinations' if logged_in?
    erb :"users/login"
  end

  post '/login' do
    user_info = {
      :email => params["email"],
      :password => params["password"]
    }
    user = User.find_by(:email => user_info[:email])
    if user && user.authenticate(user_info[:password])
      session[:user_id] = user.id
      redirect to '/destinations'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end