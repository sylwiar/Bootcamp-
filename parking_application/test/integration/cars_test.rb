require 'test_helper'

class CarsTest < ActionDispatch::IntegrationTest
  test 'user opens cars index' do
    visit '/cars'
    assert has_content? 'Cars'
  end
end
