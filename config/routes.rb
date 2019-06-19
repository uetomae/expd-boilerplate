# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#index'

  get :examples, to: 'examples#index'
  namespace :examples do
    get :layout_naked
    get :layout_global_top
    get :layout_fixed_top
    get :toast_input
    post :toast_message
  end
end
