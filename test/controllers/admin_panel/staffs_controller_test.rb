require "test_helper"

class AdminPanel::StaffsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_panel_staffs_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_panel_staffs_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_panel_staffs_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_panel_staffs_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_panel_staffs_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_panel_staffs_destroy_url
    assert_response :success
  end
end
