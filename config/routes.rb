Rails.application.routes.draw do
  root to: "weather_scraping#index"
  resources :weather_scraping , only: [:index, :show]
end
