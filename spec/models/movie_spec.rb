# spec/models/movie_spec.rb:
 
require 'spec_helper.rb'
 
describe Movie do
  describe 'searching Tmdb by keyword' do
    it 'should call Tmdb with title keywords given valid API key' do
      Tmdb::Movie.should_receive(:find).with('Inception')
      Movie.find_in_tmdb('Inception')
    end
    it 'should raise an InvalidKeyError with no API key' do
      Tmdb::Movie.stub(:find).and_raise(NoMethodError)
      Tmdb::Api.stub(:response).and_return({'code' => 401})
      lambda { Movie.find_in_tmdb('Inception') }.
        should raise_error(Movie::InvalidKeyError)
    end
  end
end
