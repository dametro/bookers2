Rails.application.routes.draw do
  # get 'users/index'
  # get 'users/show'
  # get 'users/edit'
  devise_for :users
  resources :users, only: [:index, :create, :show, :edit, :update, :destroy]
  # get 'books/index'
  # get 'books/show'
  # get 'books/edit'
  resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
    resource :favorite, only: [:create, :destroy] #単数形
    resources :book_comments, only: [:create, :destroy] #destも大事
  end
  root to: 'homes#top'
  get 'home/about' => 'homes#about'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
