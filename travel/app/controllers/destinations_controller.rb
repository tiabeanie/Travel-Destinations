class DestinationsController < ApplicationController

    get '/destinations' do
        if logged_in?
            @user = current_user
            erb :"destinations/index"
        end
    end
    
    get '/destinations/new' do
        erb :"destinations/create"
    end
    
    post '/destinations' do
        details = {
            :description => @params["description"],
            :country => @params["country"]
        }
        @destination = Destination.create_new_destination(details, session[:user_id])
        redirect to "destinations/#{@destination.id}"
    end
    
    get '/destinations/:id/edit' do
        @user = current_user
        @destination = Destination.find(params["id"])
        if @user.id != @destination.user_id
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
    
        destination = destination.update_destination(details, destination)
        redirect to "destinations/#{destination.id}"    
    end
    
    delete '/destinations/:id/delete' do
        @user = current_user
        @destination = Destination.find(params[:id])
        if @user.id != @destination.user_id
            redirect to '/destinations/#{@destination.id}'
        else
            @destination.destroy
            redirect to '/destinations'
        end
    end
    
    get '/destinations/:id' do
        @user = current_user
        @destination = destination.find(params["id"])
        erb :"destinations/show"
    end
end