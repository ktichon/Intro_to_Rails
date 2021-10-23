require "test_helper"

class DungeonsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dungeons_index_url
    assert_response :success
  end
end
