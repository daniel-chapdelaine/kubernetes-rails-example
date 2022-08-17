Rails.application.routes.draw do
  get "/", to: "words#index"
end
