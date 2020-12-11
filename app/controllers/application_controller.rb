require 'rubygems'
require 'httparty'

class ApplicationController < ActionController::API
    include HTTParty

    @@base_url = "https://developers.zomato.com/api/v2.1"

    def city_cuisines
        city_response = HTTParty.get("#{@@base_url}/cities?q=#{params[:city_name]}", {headers: {"user-key": params[:api_key]}})
        if city_response['location_suggestions'].length == 0
            render json: {error: 'no matching locations found'}
        else
            city_info = city_response['location_suggestions'][0]
            city_id = city_info['id']
            cuisine_response = HTTParty.get("#{@@base_url}/cuisines?city_id=#{city_id}", {headers: {"user-key": params[:api_key]}})
            cuisines_list = []
            for cuisine in cuisine_response["cuisines"] do
                cuisines_list << {"cusine_name" => cuisine["cuisine"]["cuisine_name"], "cuisine_id" => cuisine["cuisine"]["cuisine_id"]}
            end
            render json: {"city_info": city_info, "cusines": cuisines_list}
        end
    end

    def cuisine_daily_menus
        puts "hit /cuisine_daily_menus endpoint"
    end 

    private
    def zomato_params
        params.permit(:city_name, :api_key)
    end
end