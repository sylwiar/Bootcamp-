require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test 'it should belong to person' do
  end

  test 'it should create person object (and try to guess name) when saving' do
  end

  test 'it should be invalid without email' do
  end

  test 'it should be invalid without password on create' do
  end

  test 'it should be valid without password after create' do
  end

  test 'encrypted password should be created when setting password' do
  end

  test 'it should be invalid with wrong password confirmation' do
  end

  test 'password comparation should return false when account does not have encrypted password at all' do
  end

  test 'password comparation should return false when password is different' do
  end

  test 'password comparation should return true when password is the same' do
  end

  test 'Account.authenticate should return account object if email and password are valid' do
  end

  test 'Account.authenticate should return nil if password does not match' do
  end

  test 'Account.authenticate should return nil if email can not be found' do
  end

  test 'Account.authenticate! should raise exception if authentication can not be done' do
  end
end