require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sesion_secret, 'lovetotravel'
  end

  get '/' do
    if logged_in?
      redirect to '/destinations/index'
    end
    erb :index
  end 

  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end
end