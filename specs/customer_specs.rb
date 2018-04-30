require('minitest/autorun')
require('minitest/rg')
require_relative('../models/customer')
require_relative('../models/ticket')
require_relative('../models/film')

class TestCustomer < MiniTest::Test

  def setup
    @customer = Customer.new({ 'name' => 'Rory', 'funds' => 100 })
    @film = Film.new({ 'title' => 'Jurassic Park', 'price' => 10 })
  end

  def test_customer_name
    assert_equal("Rory", @customer.name)
  end

  def test_film_title
    assert_equal("Jurassic Park", @film.title)
  end

  def test_wallet_amount
    assert_equal(100, @customer.funds)
  end

  def test_take_money_from_funds
    @customer.take_money_from_funds(@film.price)
    assert_equal(90, @customer.funds)
  end

end
