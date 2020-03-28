class DestinationsController < ApplicationController

    get '/destinations' do 
        if logged_in?
            @destinations = destination.all
            erb :'/destinations/index'
        end
    end

    get '/destinations/create' do
        if logged_in?
          erb :'/destinations/create'
        end
    end

    get '/destinations/:id/edit' do 
        if logged_in?
            @destination = Destination.find(params[:id])
            erb :'/destinations/edit'
        end
    end

    post "/destinations/:id" do
        if logged_in?
            @destination = Destination.find(params[:id])
        unless Destination.valid_params?(params)
            redirect "/destinations/#{@destination.id}/edit?error=invalid destination"
        end
        @destination.update(params.select{|k|k=="name" || k=="description" || k=="country_id"})
        redirect "/destinations/#{@destination.id}"
    end

    get '/destinations/:id' do
        if logged_in?
            @destination = Destination.find(params[:id])
            erb :'/destinations/show'
        end
    end

    post '/destinations' do
        if logged_in?
        unless Destination.valid_params?(params)
            redirect "/destinations/new?error=invalid destination"
        end 
        Destination.create(params)
        redirect "/destinations"       
    end
end