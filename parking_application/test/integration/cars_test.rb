require 'test_helper'

class CarsTest < ActionDispatch::IntegrationTest
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