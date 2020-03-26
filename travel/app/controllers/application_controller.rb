require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :sesion_secret, 'lovetotravel'
  end

  get '/' do
    if is_logged_in?
      redirect to '/experiences'
    end
    erb :index
  end

  helpers do
    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end

end