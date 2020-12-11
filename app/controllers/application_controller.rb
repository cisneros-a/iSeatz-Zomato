class ApplicationController < ActionController::API
    
    def city_cuisines
        puts "hit /city_cuisines endpoint"
    end

    def cuisine_daily_menus
        puts "hit /cuisine_daily_menus endpoint"
    end 
end