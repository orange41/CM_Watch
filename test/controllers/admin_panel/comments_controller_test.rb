require "test_helper"

class AdminPanel::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_panel_comments_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_panel_comments_new_url
    assert_response :success
  end

  test "should get create" do
    get admin_panel_comments_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_panel_comments_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_panel_comments_update_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_panel_comments_destroy_url
    assert_response :success
  end
end
