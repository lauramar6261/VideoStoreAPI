require "test_helper"

describe MoviesController do
  let(:movie_one) {movies(:one)}

  describe 'index' do

    it "is a real working route and returns JSON" do
      get movies_path
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end

  end

  describe 'show' do

    it "works with a valid id and returns JSON" do
      get movie_path(movie_one.id)
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end

  end

  describe 'create' do

    it "works with valid data and returns JSON" do
      post movies_path, params: {
                                  title: "A movie",
                                  overview: "a description",
                                  release_date: Date.today,
                                  inventory: 5
                                }
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end

  end

end
