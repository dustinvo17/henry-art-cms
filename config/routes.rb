Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }

  get '/gallery', to: 'pages#gallery'
  get '/about' , to: 'pages#about'
  get '/admin', to: 'pages#admin'
  get '/admin/home', to: 'pages#admin'
  get '/admin/gallery', to: 'pages#admingallery'
  get '/admin/gallery/:id', to: 'pages#adminphoto'
  get 'admin/feature/:id', to: 'pages#adminfeature'
  get '/admin/blog/:id', to: 'pages#adminblog'
  get '/admin/wt/:id', to: 'pages#adminwt'
  get '/admin/about/', to: 'pages#adminabout'
  get '/admin/setting/', to: 'pages#adminsetting'
  post '/admin/feature/', to: 'pages#featureupdate'
  post '/admin/about', to: 'pages#aboutupdate'
  post 'admin/blog', to: 'pages#blogupdate'
  post '/admin/setting', to: 'pages#settingupdate'
  
  post 'admin/wt', to: 'pages#wtupdate'

  post '/images/upload', to: 'pages#upload'
  delete '/images/', to: 'pages#imgdelete'
  root 'pages#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
