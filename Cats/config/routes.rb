Rails.application.routes.draw do
  resources :cats, only: [:index, :show, :new, :create, :edit, :update]
  resources :cat_rental_requests, only: [:new, :create, :show] do
    post "approve", on: :member
    post "deny", on: :member
  end

  resources :users, only: [:new, :create]
  resource :session, only: [:create, :destroy, :new]
end
