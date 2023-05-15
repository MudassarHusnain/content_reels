require "test_helper"

class ReelsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reels_index_url
    assert_response :success
  end

  test "should get show" do
    get reels_show_url
    assert_response :success
  end

  test "should get edit" do
    get reels_edit_url
    assert_response :success
  end

  test "should get new" do
    get reels_new_url
    assert_response :success
  end
end
