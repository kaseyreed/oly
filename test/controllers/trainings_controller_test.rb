require "test_helper"

class TrainingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index,show,update" do
    get trainings_index,show,update_url
    assert_response :success
  end
end
