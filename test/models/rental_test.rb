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

  it "must be valid" do
    value(rental).must_be :valid?
  end
end
