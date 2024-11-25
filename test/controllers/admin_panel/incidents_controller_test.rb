require "test_helper"

class AdminPanel::IncidentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_panel_incidents_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_panel_incidents_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_panel_incidents_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_panel_incidents_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_panel_incidents_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_panel_incidents_destroy_url
    assert_response :success
  end
end
