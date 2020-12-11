require 'rubygems'
require 'httparty'

class ApplicationController < ActionController::API
    include HTTParty

    def city_cuisines
        response = HTTParty.get("https://developers.zomato.com/api/v2.1/cities?q=#{params[:city_name]}", {headers: {"user-key": params[:api_key]}})
        
    end

    def cuisine_daily_menus
        puts "hit /cuisine_daily_menus endpoint"
    end 

    private
    def zomato_params
        params.permit(:city_name, :api_key)
    end
end