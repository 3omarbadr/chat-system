Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :applications, param: :token do
    resources :chats, param: :number, only: [:create, :show, :index] do
      resources :messages, only: [:create, :show, :index, :update] do
        collection do
          get 'search'
        end
      end
    end
  end
end