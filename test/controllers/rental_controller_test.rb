require "test_helper"

class RentalControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get rental_new_url
    assert_response :success
  end

  test "should get edit" do
    get rental_edit_url
    assert_response :success
  end
end
