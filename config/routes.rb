Rails.application.routes.draw do
  resources :tasks do
    member do
      get 'complete'
    end
  end
end