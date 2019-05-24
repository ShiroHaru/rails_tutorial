require 'test_helper'

class Manage::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get manage_sessions_new_url
    assert_response :success
  end

end
