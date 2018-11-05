require 'test_helper'

describe Customer do
  let (:customer) {customers(:one)}

  # describe "relations" do
  #   it "has a list of rentals" do
  #     dan = users(:dan)
  #     dan.must_respond_to :votes
  #     dan.votes.each do |vote|
  #       vote.must_be_kind_of Vote
  #     end
  #   end
  #
  #   it "has a list of ranked works" do
  #     dan = users(:dan)
  #     dan.must_respond_to :ranked_works
  #     dan.ranked_works.each do |work|
  #       work.must_be_kind_of Work
  #     end
  #   end
  # end

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
end
