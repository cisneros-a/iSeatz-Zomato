Rails.application.routes.draw do
  get '/city_cuisines', to: 'application#city_cuisines'
  get '/cuisine_daily_menus', to: 'application#cuisine_daily_menus'
end
