require 'test_helper'

class PlaceRentTest < ActiveSupport::TestCase
  def setup
    @place_rent = place_rents(:bmw_at_renoma)
  end

  test 'place_rent should be valid' do
    assert @place_rent.invalid?
  end

  test 'should not save place_rent without start_date' do
    @place_rent.start_date = nil
    assert_not @place_rent.valid?
    assert @place_rent.errors.has_key?(:start_date)
  end

  test 'should not save place_rent without end_date' do
    @place_rent.end_date = nil
    assert_not @place_rent.valid?
    assert @place_rent.errors.has_key?(:end_date)
  end

  test 'should not save place_rent without car' do
    @place_rent.car = nil
    assert_not @place_rent.valid?
    assert @place_rent.errors.has_key?(:car)
  end

  test 'should not save place_rent without parking' do
    @place_rent.parking = nil
    assert_not @place_rent.valid?
    assert @place_rent.errors.has_key?(:parking)
  end
end
