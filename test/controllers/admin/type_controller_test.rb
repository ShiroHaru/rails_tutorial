require 'test_helper'

class Admin::TypeControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_type_new_url
    assert_response :success
  end

end
