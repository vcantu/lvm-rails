Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

  get 'welcome/index'

  put 'students/set_tutor'
  put 'tutors/add_student'
  patch 'tutors/:id/tags/update', to: 'tutors#update_tags', as: 'update_tutor_tags'
  patch 'students/:id/tags/update', to: 'students#update_tags', as: 'update_student_tags'

  get 'matches', to: 'matches#index', as: 'matches'

  resources :affiliates
  resources :assessments
  resources :coordinators
  resources :students
  resources :student_comments
  resources :tutors
  resources :tutor_comments
  resources :tutoring_sessions
  resources :tags
end
