Rails.application.routes.draw do

  devise_for :users, :constrollers => { 
    :registrations => "users/registrations", 
    :sessions => "users/sessions",
    :passwords => "users/passwords" }
  devise_scope :user do
    get 'signup' =>  'users/registrations#new'
    get 'signin' =>  'users/sessions#new'
    get 'signout' => 'users/sessions#destroy'
  end

  # root is only a main page

  root 'posts#index', as: 'home' #  controller that controlls showing # controller's method that calls to view(html) pattern; method.name=view(html).name

  # get - all other pages

  get 'about' => 'pages#about', as: 'about'
  get 'profile/:id' => 'pages#profile', as: 'profile'

  # resources allows to track all the controller's actions (GET, DELETE, ...)
  # use RESOURCE when routes don't need id, when we don't need index action

  resources :posts do # allowed all actions just in case :)
    resources :comments, only: [:create, :destroy] # allows to have routes like 'post/1/comment/5' 
  end

  # I don't put likes under :posts like :comments because maybe I'll need to make likes polymorphic(Ex. likes to comments)
  resources :likes, only: [:create, :destroy]
end

