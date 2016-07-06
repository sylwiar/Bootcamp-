require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  def setup
    @address = addresses(:wroclaw)
  end

  test 'address should be valid' do
    assert @address.valid?
  end

  test 'should not save address without city' do
    @address.city = nil
    assert_not @address.valid?
    assert @address.errors.has_key?(:city)
  end

  test 'should not save address without street' do
    @address.street = nil
    assert_not @address.valid?
    assert @address.errors.has_key?(:street)
  end

  test 'should not save address without zip_code' do
    @address.zip_code = nil
    assert_not @address.valid?
    assert @address.errors.has_key?(:zip_code)
  end

  test 'should not save address with wrong zip code' do
    @address.zip_code = '123456'
    assert_not @address.valid?
    assert @address.errors.has_key?(:zip_code)
  end
end
