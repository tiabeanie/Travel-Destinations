class destinationsController < ApplicationController
    before '/destinations/*' do
      if !is_logged_in?
        flash[:login] = "You need to be logged in for that!"
        redirect to '/login'
      end
    end
  
    get '/destinations' do
      if is_logged_in?
        @user = current_user
        erb :"destinations/destinations"
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
  
      flash[:success] = "You added a new destination!!"
      redirect to "destinations/#{@destination.id}"
    end
  
    get '/destinations/:id/edit' do
      @user = current_user
      @destination = Destination.find(params["id"])
      if @user.id != @destination.user_id
        flash[:edit_user] = "You can only edit your own destinations"
        redirect to "/destinations/#{@destination.id}"
      end
      erb :"destinations/edit"
    end
  
    patch '/destinations/:id' do
      destination = Destination.find(params[:id])
  
      details = {
        :description => params["description"],
        :country => params["country"]
      }
      category_name = params["category"]["name"]
      category_ids = params["category"]["category_ids"]
  
      is_empty?(details, "destinations/#{params[:id]}/edit")
  
      exp = Destination.update_destination(details, category_name, category_ids, destination)
  
      flash[:success] = "Your destination has been updated!"
      redirect to "destinations/#{exp.id}"
    end
  
    delete '/destinations/:id/delete' do
      @user = current_user
      @destination = Destination.find(params[:id])
      if @user.id != @destination.user_id
        flash[:edit_user]
        redirect to '/destinations/#{@destination.id}'
      else
        @destination.destroy
        flash[:deleted] = "Your destination has been deleted"
        redirect to '/destinations'
      end
    end
  
    get '/destinations/:id' do
      @user = current_user
      @destination = Destination.find(params["id"])
      erb :"destinations/show"
    end
  
  end