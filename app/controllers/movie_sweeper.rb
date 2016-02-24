class MovieSweeper < ActionController::Caching::Sweeper
  observe Movie
  # if a movie is created or deleted, movie list becomes invalid
  #   and rendered partials become invalid
  def after_save(movie)    ; invalidate ; end
  def after_destroy(movie) ; invalidate ; end
  private
  def invalidate
    expire_action :action => ['index', 'show']
    expire_fragment 'movie'
  end
end
