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
        response = HTTParty.get("#{@@base_url}/search?entity_id=#{params[:city_id]}&entity_type=city&count=2&cuisines=#{params[:cuisine_id]}",  {headers: {"user-key": params[:api_key]}})
        if response['restaurants'].length == 0
            render json: {error: 'no restaurants found'}
        else 
           menus = aggregate_menus(response['restaurants'])
           if menus.length == 0
            render json: {"error": "no daily menus found"}
           else 
            if menus.length > 3 
                menus = menus.slice(0,3)
            end 
            render json: {menus: menus}
           end
        end 
        
    end 

    private
    def zomato_params
        params.permit(:city_name, :api_key, :city_id, :cuisine_id)
    end

    def aggregate_menus(restaurants)
        daily_menus = []
        for restaurant in restaurants do
            daily_menu_response = HTTParty.get("#{@@base_url}/dailymenu?res_id=#{restaurant["restaurant"]['id']}", {headers: {"user-key": params[:api_key]}})
            if daily_menu_response.code == 200
                daily_menus << daily_menu_response
            end 
        end
        return daily_menus
    end 
end