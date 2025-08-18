require "test_helper"

class BragsControllerTest < ActionDispatch::IntegrationTest
  test "should get document" do
    get brags_document_url
    assert_response :success
  end
end
