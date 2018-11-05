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

  describe 'relationships' do
    it 'has many rentals' do
      movie_one.must_respond_to :rentals

      movie_one.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end

    it 'has many customers through rentals' do
      movie_one.must_respond_to :customers

      movie_one.customers.each do |customer|
        customer.must_be_kind_of Customer
      end
    end

    it 'returns an empty set if there are no rentals' do
      Rental.all.each do |rental|
        rental.destroy
      end

      movie_one.rentals.any?.must_equal false

      movie_one.customers.any?.must_equal false
    end
  end

  describe 'custom methods' do
    it 'initializes available inventory based off inventory input' do
      movie = Movie.create(title:"Robots Of Eternity",
                        overview:"The laid-back life of a woman is going in a different direction as a childhood friend enters her life.",
                        release_date:"2007-10-10",
                        inventory:7)
      movie.must_respond_to :available_inventory
      movie.available_inventory.must_equal movie.inventory
    end
  end


end
