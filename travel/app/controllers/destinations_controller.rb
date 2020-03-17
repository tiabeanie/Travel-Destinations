class ExperiencesController < ApplicationController
    before '/experiences/*' do
      if !is_logged_in?
        flash[:login] = "You need to be logged in for that!"
        redirect to '/login'
      end
    end
  
    get '/experiences' do
      if is_logged_in?
        @user = current_user
        erb :"experiences/experiences"
      else
        flash[:login] = "You need to be logged in for that!"
        redirect to '/login'
      end
    end
  
    get '/destinations/users' do
      @user = current_user
      erb :"destinations/destinations_from_user"
    end
  
    get '/destinations/new' do
      @categories = Category.all
      erb :"destinations/create"
    end
  
    post '/destinations' do
      details = {
        :description => @params["description"],
        :country => @params["country"]
      }
  
      is_empty?(details, 'destinations/new')
  
      @destination = Destination.create_new_destinaion(details, country_name, country_id, session[:user_id])
  
      flash[:success] = "You created a new destination!"
      redirect to "destinations/#{@destination.id}"
    end
  
    get '/destinations/:id/new_from_user' do
      user = current_user
      @destination = Destination.find(params["id"])
      if @destination.user_id == user.id
        flash[:add_from_user] = "You already added this destination!"
        redirect to "/destinations/#{params["id"]}"
      else
        erb :"destinations/create_from_user"
      end
    end
  
    post '/destinations/new_from_user' do
      details = {
        :description => @params["description"],
        :country => @params["country"]
      }
  
      is_empty?(details, "destinations/#{params[:id]}/new_from_user")
  
      @destination = Destination.create_new_destination(details, country_name, country_id, session[:user_id])
  
