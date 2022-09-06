Rails.application.routes.draw do
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "customers/registrations",
    sessions: "customers/sessions",
  }
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admins/sessions",
  }

  # ゲストログイン
  devise_scope :customer do
    post "customers/guest_sign_in", to: "customers/sessions#guest_sign_in"
  end

  scope module: :customer do
    root to: "homes#top"
    get "/about" => "homes#about"

    resources :customers, only: [:show, :edit, :update] do
      get "confirm" => "customers#confirm"
      patch "withdrawal" => "customers#withdrawal"
      get "favorites" => "customers#favorites"
    end

    resources :documents do
      resource :favorites, only: [:create, :destroy]
      collection do
        get "word_search" => "documents#word_search"
        get "tag_search" => "documents#tag_search"
      end
    end
  end

  namespace :admin do
    get "/" => "homes#top"

    resources :customers, only: [:show, :edit, :update] do
      collection do
        get "word_search" => "customers#word_search"
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
