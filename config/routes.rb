Rails.application.routes.draw do
  devise_scope :user do
    # Redirests signing out users back to sign-in
    # get "users", to: "devise/sessions#new"
    get "users", to: "devise/sessions#new"
    get "/users/sign_out" => "devise/sessions#destroy"
  end
  
  root "home#index"
  get "integration", to: "integration#index"
  get "callback_integration", to: "integration#facebook_callback"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get "disconnect_facebook", to: "integration#destroy_session"
  get "share_post", to: "integration#post_content"
  post "microphone", to: "templates#show_microphone"
  get "record_audio", to: "templates#record_microphone_audionew"
  get "text_to_speech", to: "templates#text_to_speech"
  get "templates/audio_index"
  get "videos/render_video"

  get "generate_text", to: "chat_gpt#new"
  get "send_response", to: "chat_gpt#send_to_chat"
  get "text_to_video", to: "reels#text_to_video"
  post '/shotstack_callback', to: 'reels#text_to_video'
  get "stackio_integration/create"


  resources :projects
  resources :reels do
    member do
      get "script", to: "reels#script"
      get "editor", to: "reels#editor"
    end
  end
  
  resources :templates
  
  resources :videos, only: [:new, :create, :index]
end
