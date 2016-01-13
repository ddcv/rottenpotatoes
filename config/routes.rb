Rottenpotatoes::Application.routes.draw do
# add to routes.rb, just before or just after 'resources :movies' :
# Route that posts 'Search TMDb' form

  resources :movies
  post '/movies/search_tmdb'
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end