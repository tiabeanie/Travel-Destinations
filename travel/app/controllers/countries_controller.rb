class CountriesController < ApplicationController

  get '/countries' do
    if !logged_in?
      @countries = Country.all
      erb :"countries/index"
    end
  end

  get "/countries/new" do
    @error_message = params[:error]
    erb :'countries/new'
  end

  get "/countries/:id/edit" do
    @error_message = params[:error]
    @country = Country.find(params[:id])
    erb :'countries/edit'
  end

  post "/countries/:id" do
    @country = Country.find(params[:id])
    unless Country.valid_params?(params)
      redirect "/countries/#{@country.id}/edit?error=invalid country"
    end
    @country.update(params.select{|k|k=="name" || k=="continent"})
    redirect "/countries/#{@country.id}"
  end

  get "/countries/:id" do
    @country = Country.find(params[:id])
    erb :'countries/show'
  end

  post "/countries" do

    unless Country.valid_params?(params)
      redirect "/countries/new?error=invalid country"
    end
    Country.create(params)
    redirect "/countries"
  end
end