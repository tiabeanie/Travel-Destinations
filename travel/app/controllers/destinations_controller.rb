class DestinationsController < ApplicationController

  get '/destinations' do 
      if logged_in?
          @destinations = destination.all
          erb :'/destinations/index'
      else
          redirect '/login'
      end
  end

  get '/destinations/create' do
      if logged_in?
          erb :'/destinations/create'
      else 
          redirect '/login'
      end
  end

  post '/destinations' do
      if params.empty?
          flash[:error] = "All fields must be filled in"
          redirect '/destinations/create'
      elsif logged_in? && !params.empty?
          @destination = current_user.destinations.create(name: params[:name], description: params[:description], country: params[:country])
          if @destination.save
              redirect "/destinations/#{@destination.id}"
          else
              flash[:error] = "Your destination could not be saved. Try again!"
              redirect '/destinations/create'
          end
      else 
          flash[:error] = "You must be logged in to see your destinatons"
          redirect '/login'
      end
      current_user.save
  end

  get '/destinations/:id' do
      if logged_in?
          @destination = destination.find_by_id(params[:id])
          erb :'/destinations/show'
      else 
          flash[:error] = "You must be logged in to view destinations."
          redirect '/login'
      end
  end

  get '/destinations/:id/edit' do 
      @destination = destination.find_by_id(params[:id])
      if logged_in? && current_user.destinations.include?(@destination)
          erb :'/destinations/edit'
      else 
          flash[:error] = "You must be logged in to edit a destination."
          redirect '/login'
      end
  end

  patch '/destinations/:id' do
      @destination = destination.find_by_id(params[:id])
      if params.empty?
          flash[:error] = "All fields must be filled in"
          redirect "/destinations/#{@destination.id}/edit"
      elsif logged_in? && !params.empty? && current_user.destinations.include?(@destination)
          @destination.update(name: params[:name], description: params[:description], country: params[:country])
          redirect "/destinations/#{@destination.id}"
      else 
          flash[:error] = "You must be logged in."
          redirect '/login'
      end
      
  end

  delete '/destinations/:id/delete' do
      if logged_in?
          @destination = destination.find_by_id(params[:id])
          if @destination.user == current_user then @destination.delete else redirect '/login' end
      else 
          flash[:error] = "You must be logged in."
          redirect '/login'
      end
      redirect '/destinations'
  end
end