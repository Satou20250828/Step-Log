require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    # home_index_url を root_url に書き換えます
    get root_url
    assert_response :success
  end
end
