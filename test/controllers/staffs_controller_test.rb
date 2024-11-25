require "test_helper"

class StaffsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get staffs_show_url
    assert_response :success
  end

  test "should get edit" do
    get staffs_edit_url
    assert_response :success
  end

  test "should get update" do
    get staffs_update_url
    assert_response :success
  end
end
