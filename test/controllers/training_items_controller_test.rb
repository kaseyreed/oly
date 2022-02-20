require "test_helper"

class TrainingItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get training_items_update_url
    assert_response :success
  end
end
