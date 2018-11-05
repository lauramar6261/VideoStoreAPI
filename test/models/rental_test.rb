require "test_helper"
#
# validates_presence_of :checkout_date
# validates_presence_of :due_date
#
# belongs_to :customer
# belongs_to :movie
#
#
# def initialize(attributes={})
#   super
#   self.active? = true
# end


describe Rental do
  let(:rental_one) {rentals(:one)}

  describe "validations" do
    it "is valid with correct data" do
      rental_one.valid?.must_equal true
    end

    it "requires a checkout date" do
      rental_one.checkout_date = nil
      rental_one.save

      rental_one.valid?.must_equal false
      rental_one.errors.messages.must_include :checkout_date
    end

    it "requires a due date" do
      rental_one.due_date = nil
      rental_one.save

      rental_one.valid?.must_equal false
      rental_one.errors.messages.must_include :due_date
    end

    it 'requires a customer' do
      rental_one.customer = nil
      rental_one.save

      rental_one.valid?.must_equal false
      rental_one.errors.messages.must_include :customer
    end

  end

  describe 'relationships' do
    it 'belongs to a customer' do
      rental_one.must_respond_to :customer

      rental_one.customer.must_be_kind_of Customer
    end

    it 'belongs to a movie' do
      rental_one.must_respond_to :movie

      rental_one.movie.must_be_kind_of Movie

    end
  end

  describe 'custom methods' do
    it 'initializes active to true' do
      rental = Rental.create(customer: customers(:one),
                        movie: movies(:one),
                        checkout_date: '2018-11-05',
                        due_date: '2018-11-12')
      rental.must_respond_to :active
      rental.active.must_equal true
    end
  end


end
