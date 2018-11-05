require "test_helper"

# validates :title, presence: true
# validates :overview, presence: true
# validates :release_date, presence: true
# validates :inventory, presence: true
#
# has_many :rentals
# has_many :customers, through: :rentals
#
# def initialize(attributes={})
#   super
#   self.available_inventory = self.inventory
# end


describe Movie do
  let(:movie_one) {movies(:one)}
  let(:movie_two) {movies(:two)}

  describe "validations" do
    it "requires a title" do
      movie_one.title = nil
      movie_one.save

      movie_one.valid?.must_equal false
      movie_one.errors.messages.must_include :title
    end

    it "requires an overview" do
      movie_one.overview = nil
      movie_one.save

      movie_one.valid?.must_equal false
      movie_one.errors.messages.must_include :overview
    end

    it "requires a release date" do
      movie_one.release_date = nil
      movie_one.save

      movie_one.valid?.must_equal false
      movie_one.errors.messages.must_include :release_date
    end

    it "requires an inventory entry" do
      movie_one.inventory = nil
      movie_one.save

      movie_one.valid?.must_equal false
      movie_one.errors.messages.must_include :inventory
    end

    it "requires an available inventory entry" do
      movie_one.available_inventory = nil
      movie_one.save

      movie_one.valid?.must_equal false
      movie_one.errors.messages.must_include :available_inventory
    end

    it "inventory must be numeric and non-negative" do
      movie_one.inventory = "applesauce"
      movie_one.save
      movie_one.valid?.must_equal false
      movie_one.errors.messages.must_include :inventory

      movie_one.inventory = 0
      movie_one.save
      movie_one.valid?.must_equal true

      movie_one.inventory = -1
      movie_one.save
      movie_one.valid?.must_equal false
      movie_one.errors.messages.must_include :inventory
    end

    it "available inventory must be numeric and non-negative" do
      movie_one.available_inventory = "potatoes"
      movie_one.save
      movie_one.valid?.must_equal false
      movie_one.errors.messages.must_include :available_inventory

      movie_one.available_inventory = 0
      movie_one.save
      movie_one.valid?.must_equal true

      movie_one.available_inventory = -1
      movie_one.save
      movie_one.valid?.must_equal false
      movie_one.errors.messages.must_include :available_inventory
    end

  end


end
