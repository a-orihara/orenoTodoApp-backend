Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # <このファイル内で利用可能なDSLの詳細については、https://guides.rubyonrails.org/routing.html を参照してください。>
  namespace :api do
    namespace :v1 do
      resources :todos, only: %i[index show create update destroy]
    end
  end
end
