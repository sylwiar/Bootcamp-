require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  test "should work" do
    assert_equal "Parkings", page_title_hum
  end

  private

  def page_title
    "parkings"
  end
end