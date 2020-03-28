class CountriesController < ApplicationController

  get '/countries' do
    if !logged_in?
      @countries = Country.all
      erb :"countries/index"
    end
  end

  get '/countries/:id' do
    if logged_in?
      @country = Country.find(params["id"])
      erb :"countries/show"
    end
  end
end