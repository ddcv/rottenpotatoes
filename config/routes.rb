Rottenpotatoes::Application.routes.draw do

  get  'auth/:provider/callback' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  get  'auth/failure' => 'sessions#failure'
# add to routes.rb, just before or just after 'resources :movies' :
# Route that posts 'Search TMDb' form

  resources :movies do
    resources :reviews
  end
  post '/movies/search_tmdb'
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end
