class Country < ActiveRecord::Base
    has_many :destinations
  
    def self.valid_params?(params)
      return !params[:name].empty? 
    end

  end
