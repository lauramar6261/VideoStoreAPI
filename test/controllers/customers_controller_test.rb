require "test_helper"

describe CustomersController do
  describe 'index' do

    it "is a real working route and returns JSON" do
      get customers_path
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :success
    end

    it "returns an Array" do
      get customers_path
      body = JSON.parse(response.body)
      expect(body).must_be_kind_of Array
    end

    it "returns all of the customers" do
      get customers_path
      body = JSON.parse(response.body)
      expect(body.length).must_equal Customer.count
    end

    it "returns customers with exactly the required fields" do
      keys = %w(id movies_checked_out_count name phone postal_code registered_at)

      get customers_path

      body = JSON.parse(response.body)

      body.each do |customer|
        expect(customer.keys.sort).must_equal keys
        expect(customer.keys.length).must_equal keys.length
      end
    end

    it "can sort customers based on params" do
      sort_values = %w(name registered_at postal_code)

      sort_values.each do |value|
      get customers_path, params: {"sort" => value}

      body = JSON.parse(response.body)

        (body.length - 1).times do |i|
          expect(body[i][value]).must_be :<, body[i+1][value]
        end
      end
    end

    it "can limit the customers per page" do
      get customers_path, params: {"p" => 1, "n" => 2}

      body = JSON.parse(response.body)

      expect(body.length).must_equal 2
    end
  end

end
