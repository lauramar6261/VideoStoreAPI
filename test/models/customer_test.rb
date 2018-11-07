require 'test_helper'

describe Customer do
  let (:customer) {customers(:one)}
  let (:customertwo) {customers(:two)}


  describe "relations" do
    it "has a list of rentals" do
      customertwo.must_respond_to :rentals
      customertwo.rentals.each do |rental|
        rental.must_be_kind_of Rental
      end
    end

    it "has a list of movies" do
      customertwo.must_respond_to :movies
      customertwo.movies.each do |movie|
        movie.must_be_kind_of Movie
      end
    end
  end

  describe "validations" do
    it "requires a name - negative" do
      customer.name = nil
      customer.valid?. must_equal false
      customer.errors.messages.must_include :name
    end

    it "requires a name - positive" do
      customer.name = "Laura"
      customer.valid?.must_equal true
    end

    it "requires register_at - negative" do
      customer.registered_at = nil
      customer.valid?.must_equal false
      customer.errors.messages.must_include :registered_at
    end

    it "requires register_at - positive" do
      customer.registered_at = customers(:two).registered_at
      customer.valid?.must_equal true
      customer.errors.messages.wont_include :registered_at
    end

    it "requires address - negative" do
      customer.address = nil
      customer.valid?.must_equal false
      customer.errors.messages.must_include :address
    end

    it "requires address - positive" do
      customer.address = customers(:two).registered_at
      customer.valid?.must_equal true
    end

    it "requires city - negative" do
      customer.address = nil
      customer.valid?.must_equal false
      customer.errors.messages.must_include :address
    end

    it "requires city - positive" do
      customer.address = customers(:two).city
      customer.valid?.must_equal true
    end

    it "requires state - negative" do
      customer.state = nil
      customer.valid?.must_equal false
      customer.errors.messages.must_include :state
    end

    it "requires state - positive" do
      customer.state = customers(:two).state
      customer.valid?.must_equal true
    end

    it "requires postal_code - negative" do
      customer.postal_code = nil
      customer.valid?.must_equal false
      customer.errors.messages.must_include :postal_code
    end

    it "requires postal_code - positive" do
      customer.state = customers(:two).postal_code
      customer.valid?.must_equal true
    end

    it "requires phone - negative" do
      customer.phone = nil
      customer.valid?.must_equal false
      customer.errors.messages.must_include :phone
    end

    it "requires phone - positive" do
      customer.phone = customers(:two).phone
      customer.valid?.must_equal true
    end
  end

  describe 'custom methods' do
    it 'movies_checked_out_count works' do
      customer.movies_checked_out_count.must_equal 1

      customertwo.movies_checked_out_count.must_equal 2
      customertwo.rentals.count.must_equal 3

    end

  end
end
