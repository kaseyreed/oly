require "test_helper"

class MovementsControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get movements_list_url
    assert_response :success
  end
end
