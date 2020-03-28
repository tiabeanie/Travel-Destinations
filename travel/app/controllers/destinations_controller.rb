class DestinationsController < ApplicationController

    get '/destinations' do
         @destinations = Destination.all
         erb :'/destinations/index'
    end

    get '/destinations/create' do
        erb :'/destinations/create'
    end

    get '/destinations/:id/edit' do 
        @destination = Destination.find_by_id(params[:id])
        erb :'/destinations/edit'
    end

    post "/destinations/:id" do
            @destination = Destination.find_by_id(params[:id])
        unless Destination.valid_params?(params)
            redirect "/destinations/#{@destination.id}/edit?error=invalid destination"
        end
        @destination.update(params.select{|k|k=="name" || k=="description" || k=="country_id"})
        redirect "/destinations/#{@destination.id}"
    end

    get '/destinations/:id' do
        @destination = Destination.find_by_id(params[:id])
        erb :'/destinations/show'
    end

    post '/destinations' do
        unless Destination.valid_params?(params)
            redirect "/destinations/create?error=invalid destination"
        end 
        Destination.create(params)
        redirect "/destinations" 
    end      
end