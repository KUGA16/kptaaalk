require 'test_helper'

class GroupUsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get group_users_new_url
    assert_response :success
  end

end
