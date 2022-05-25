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

  # resources allows to track all the controller's actions (GET, DELETE, ...)

  resources :posts do
    resources :comments # allows to have routes like 'post/1/comment/5' 
  end
end

