require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  def setup
    @person = people(:steve)
  end

  test 'person should be valid' do
    assert @person.valid?
  end

  test 'should not save person without first_name' do
    @person.first_name = nil
    assert_not @person.valid?
    assert @person.errors.has_key?(:first_name)
  end

  test 'should display full name' do
    assert_equal("Steve Jobs", @person.name)
  end

  test "should display only first name" do
    @person.last_name = nil
    assert_equal("Steve", @person.name)
  end
end
