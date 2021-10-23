require "test_helper"

class ChamberPurposesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chamber_purposes_index_url
    assert_response :success
  end

  test "should get show" do
    get chamber_purposes_show_url
    assert_response :success
  end
end
