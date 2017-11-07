require 'test_helper'

class MatchingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @matching = matchings(:one)
  end

  test "should get index" do
    get matchings_url
    assert_response :success
  end

  test "should get new" do
    get new_matching_url
    assert_response :success
  end

  test "should create matching" do
    assert_difference('Matching.count') do
      post matchings_url, params: { matching: { user1_id: @matching.user1_id, user2_id: @matching.user2_id, user3_id: @matching.user3_id, user4_id: @matching.user4_id } }
    end

    assert_redirected_to matching_url(Matching.last)
  end

  test "should show matching" do
    get matching_url(@matching)
    assert_response :success
  end

  test "should get edit" do
    get edit_matching_url(@matching)
    assert_response :success
  end

  test "should update matching" do
    patch matching_url(@matching), params: { matching: { user1_id: @matching.user1_id, user2_id: @matching.user2_id, user3_id: @matching.user3_id, user4_id: @matching.user4_id } }
    assert_redirected_to matching_url(@matching)
  end

  test "should destroy matching" do
    assert_difference('Matching.count', -1) do
      delete matching_url(@matching)
    end

    assert_redirected_to matchings_url
  end
end
