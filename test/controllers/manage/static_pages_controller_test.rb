require 'test_helper'

class Manage::StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get manage_static_pages_home_url
    assert_response :success
  end

end
