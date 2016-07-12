require 'test_helper'

class CarsTest < ActionDispatch::IntegrationTest
  setup do
    visit "/accounts/sign_in"
    fill_in "Email", with: "jankowalski@gmail.com"
    fill_in "Password", with: "12345678"
    click_button "Log in"
  end

  test 'user opens cars index' do
    visit '/cars'
    assert has_content? 'Cars'
  end

  test 'user creates a new car' do
    visit '/cars/new'
    fill_in 'Model', with: 'Ford'
    fill_in 'Registration number', with: 'DW12347'
    click_button 'Create Car'
    assert has_content? 'Cars'
    assert has_content? 'Model: Ford'
    assert has_content? 'Registration number: DW12347'
  end
end