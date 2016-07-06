require 'test_helper'

class ParkingTest < ActiveSupport::TestCase
  def setup
    @parking = parkings(:renoma)
  end

  test 'parking should be valid' do
    assert @parking.valid?
  end

  test 'should not save parking without places' do
    @parking.registration_number = nil
    assert_not @parking.valid?
    assert @parking.errors.has_key?(:places)
  end

  test 'should not save parking without hour_price' do
    @parking.model = nil
    assert_not @parking.valid?
    assert @parking.errors.has_key?(:hour_price)
  end

  test 'should not save parking without day_price' do
    @parking.owner = nil
    assert_not @parking.valid?
    assert @parking.errors.has_key?(:day_price)
  end

  test 'should not save parking without kind' do
    @parking.owner = nil
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
end
