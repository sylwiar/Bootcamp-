require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  def setup
    @account = accounts(:one)
  end

  test 'account should be valid' do
    assert @account.valid?
  end

  test 'should not save account without email' do
    @account.email = nil
    assert_not @account.valid?
    assert @account.errors.has_key?(:email)
  end

  test 'when account has no valid email' do
    @account.email = 'mail@mail,+com.'
    assert_not @account.valid?
    assert @account.errors.has_key?(:email)
  end
end