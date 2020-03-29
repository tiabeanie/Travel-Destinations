class CountriesController < ApplicationController
  get '/countries' do
    @countries = Country.all.sort_by{|c| c.name}
    erb :"countries/index"
  end

  get '/countries/:id' do
    @country = Country.find(params["id"])
    erb :"countries/show"
  end
end