require 'test_helper'

class ParkingTest < ActiveSupport::TestCase
  def setup
    @parking = parkings(:renoma)
    @public = parkings(:public)
    @private = parkings(:private)
    @end_date = @parking.finish_rental
  end

  test 'parking should be valid' do
    assert @parking.valid?
  end

  test 'should not save parking without places' do
    @parking.places = nil
    assert_not @parking.valid?
    assert @parking.errors.has_key?(:places)
  end

  test 'should not save parking without hour_price' do
    @parking.hour_price = nil
    assert_not @parking.valid?
    assert @parking.errors.has_key?(:hour_price)
  end

  test 'should not save parking without day_price' do
    @parking.day_price = nil
    assert_not @parking.valid?
    assert @parking.errors.has_key?(:day_price)
  end

  test 'should not save parking without kind' do
    @parking.kind = nil
    assert_not @parking.valid?
    assert @parking.errors.has_key?(:kind)
  end

  test "should have numeric hour_price" do
    @parking.hour_price = "test"
    assert_not @parking.valid?
    assert @parking.errors.has_key?(:hour_price)
  end

  test "kind should have value from list" do
    @parking.kind = "something"
    assert @parking.invalid?
  end

  test "should set end_date before destroying" do
    assert_in_delta(Time.now, @end_date, delta = 0.001)
  end

  test "should get a list of all public parkings" do
    assert_equal([@public], Parking.public_parkings)
  end

  test "should get a list of all private parkings" do
    assert_equal([@private, @parking], Parking.private_parkings)
  end

  test "should get a list of all parkings in day_price range" do
    assert_equal([@public], Parking.day_price_between(12.00, 20.00))
  end

  test "should get a list of all parkings in hour_price range" do
    assert_equal([@parking, @public], Parking.hour_price_between(1.00, 5.00))
  end  

  test "should get a list of all parkings in the given city" do
    assert_equal([@private, @parking], Parking.in_city("Wroclaw"))
  end
end
