require "test_helper"

class LeaveRequestReviewsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get leave_request_reviews_create_url
    assert_response :success
  end
end
