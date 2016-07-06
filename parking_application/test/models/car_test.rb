require 'test_helper'

class CarTest < ActiveSupport::TestCase
  def setup
    @car = cars(:bmw)
  end

  test 'car should be valid' do
    assert @car.valid?
  end

  test 'should not save car without registration_number' do
    @car.registration_number = nil
    assert_not @car.valid?
    assert @car.errors.has_key?(:registration_number)
  end

  test 'should not save car without model' do
    @car.model = nil
    assert_not @car.valid?
    assert @car.errors.has_key?(:model)
  end

  test 'should not save car without owner' do
    @car.owner = nil
    assert_not @car.valid?
    assert @car.errors.has_key?(:owner)
  end
end
