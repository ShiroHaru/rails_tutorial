require 'test_helper'

class Manage::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get manage_users_new_url
    assert_response :success
  end

end
