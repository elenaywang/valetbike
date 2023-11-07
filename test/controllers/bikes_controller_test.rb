require "test_helper"

class BikesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get bikes_index_url
    assert_response :success
  end

  test "should get _row" do
    get bikes__row_url
    assert_response :success
  end
end
