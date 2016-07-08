require 'test_helper'

class ParkingsTest < ActionDispatch::IntegrationTest
  test 'user opens parkings index' do
    visit '/parkings'
    assert has_content? 'Parkings'
  end

  test 'user opens parkings details' do
    visit '/parkings'
    first( :link, 'Show' ).click
    assert has_link? 'Back'
  end

  test 'user updates a parking' do
    visit '/parkings'
    first( :link, 'Edit' ).click
    assert has_content? 'Edit parking'
  end
end