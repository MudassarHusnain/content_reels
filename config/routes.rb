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
  devise_for :users

end