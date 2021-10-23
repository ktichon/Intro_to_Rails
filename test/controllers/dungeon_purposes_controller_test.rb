require "test_helper"

class DungeonPurposesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dungeon_purposes_index_url
    assert_response :success
  end

  test "should get show" do
    get dungeon_purposes_show_url
    assert_response :success
  end
end
