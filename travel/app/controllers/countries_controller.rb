class CountriesController < ApplicationController
  before '/countries/*' do
    if !is_logged_in?
      redirect "/users/login?error=you need to be logged in for that"
    end
  end

  get '/countries' do
    if !is_logged_in?
      redirect "/users/login?error=you need to be logged in for that"
    end
    @countries = Country.all.sort_by{|c| c.name}
    erb :"countries/index"
  end

  get '/countries/:id' do
    @country = Country.find(params["id"])
    erb :"countries/show"
  end
end