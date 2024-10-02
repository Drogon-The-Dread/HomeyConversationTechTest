# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :projects, only: %i[index show] do
    patch :status_transition, on: :member
    post :create_user_comment, on: :member

    resources :project_history_items, only: [:show] do
      post :create_user_comment, on: :collection
    end
  end

  # Defines the root path route ("/")
  root 'projects#index'
end
