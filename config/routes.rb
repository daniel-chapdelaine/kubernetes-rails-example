Rails.application.routes.draw do
  get "/", to: "words#index"
  post "/words/new", to: "words#new"
end
