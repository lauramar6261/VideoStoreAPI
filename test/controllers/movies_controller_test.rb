require "test_helper"

describe MoviesController do
  let(:movie_one) {movies(:one)}

  describe 'index' do

    it "is a real working route and returns JSON" do
      get movies_path
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end

    it "returns an Array" do
      get movies_path
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Array
    end

    it "returns all of the movies" do
      get movies_path
      body = JSON.parse(response.body)
      expect(body.length).must_equal Movie.count
    end

    it "returns movies with exactly the required fields" do
      keys = %w(id release_date title)

      get movies_path

      body = JSON.parse(response.body)

      body.each do |movie|
        expect(movie.keys.sort).must_equal keys
        expect(movie.keys.length).must_equal keys.length
      end
    end

  end

  describe 'show' do

    it "works with a valid id and returns JSON" do
      get movie_path(movie_one.id)
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end

    it "responds with a 404 message if no movie is found" do
      get movie_path(-1)
      must_respond_with :not_found
    end

    it "returns a movie with exactly the required fields" do
      keys = %w(available_inventory inventory overview release_date title)

      get movie_path(movie_one.id)

      body = JSON.parse(response.body)

      expect(body.keys.sort).must_equal keys
      expect(body.keys.length).must_equal keys.length
    end

  end

  describe 'create' do
    let(:movie_params) {
                        {
                          title: "a movie",
                          overview: "a description",
                          release_date: Date.today,
                          inventory: 5
                        }
                      }

    it "returns JSON" do
      post movies_path, params: movie_params
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end


    it "creates a new movie given valid data" do
      expect {
          post movies_path, params: movie_params
        }.must_change "Movie.count", 1

      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Hash
      expect(body).must_include "id"

      movie = Movie.find(body["id"].to_i)

      expect(movie.title).must_equal movie_params[:title]
      expect(movie.overview).must_equal movie_params[:overview]
      expect(movie.release_date).must_equal movie_params[:release_date]
      expect(movie.inventory).must_equal movie_params[:inventory]
      expect(movie.available_inventory).must_equal movie_params[:inventory]
      must_respond_with :success
    end

    it "returns an error for invalid movie data" do

      movie_params[:title] = nil

      expect {
            post movies_path, params: movie_params
          }.wont_change "Movie.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body).must_include "errors"
      expect(body["errors"]["movie"]).must_include "title"
      must_respond_with :bad_request
    end
  end

  describe 'custom method: current' do
    let(:id) {movies(:one).id }
    it "is a real working route and returns JSON" do
      get current_path(id)
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end

    it "returns an Array" do
      id = movies(:one).id
      get current_path(id)
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Array
    end

    it "returns customer of currently checkout movie - valid data" do
      expect {
        get current_path(id)
      }.wont_change "Movie.count"

      body = JSON.parse(response.body)

      expect(body.first).must_include "customer_id"
    end

    it "returns error for invalid movie" do
      id = 0

      expect {
        get current_path(id)
      }.wont_change "Movie.count"

      body = JSON.parse(response.body)

      expect(body).must_be_kind_of Hash
      expect(body.first).must_include "errors"
    end
  end

end
