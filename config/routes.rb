Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # <このファイル内で利用可能なDSLの詳細については、https://guides.rubyonrails.org/routing.html を参照してください。>
  namespace :api do
    namespace :v1 do
      resources :todos, only: %i[index show create update destroy]
    end
  end
end

# GET	/todos	todos#index	すべてのtodosの一覧を表示
# GET	/todos/new	todos#new	todosを1つ作成するためのHTMLフォームを返す
# POST	/todos	todos#create	todosを1つ作成する
# GET	/todos/:id	todos#show	特定のtodosを表示する
# GET	/todos/:id/edit	todos#edit	todos編集用のHTMLフォームを1つ返す
# PATCH/PUT	/todos/:id	todos#update	特定のtodosを更新する
# DELETE	/todos/:id	todos#destroy	特定のtodosを削除する
