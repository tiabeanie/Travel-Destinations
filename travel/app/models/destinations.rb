class Destination < ActiveRecord::Base
    belongs_to :user
  
    def self.valid_params?(params)
      return !params[:name].blank? && !params[:country].blank?
    end
  end