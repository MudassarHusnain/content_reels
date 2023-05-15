Rails.application.routes.draw do
  devise_scope :user do
    # Redirests signing out users back to sign-in
    # get "users", to: "devise/sessions#new"
    get "users", to: "devise/sessions#new"
    get '/users/sign_out' => 'devise/sessions#destroy'

  end
  root "home#index"
  get 'text_to_speech', to: 'text_to_speech#text_to_speech'
  get 'text_to_speech/index'
  get 'integration', to: 'integration#index'
  get 'fb_integration', to: 'integration#create'
  get 'callback_integration', to: 'integration#facebook_callback'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # get "/auth/facebook/callback", to: "omniauth_callbacks#facebook"
  get '/auth/facebook/callback', to: 'integration#facebook_callback'
  resource :projects
end