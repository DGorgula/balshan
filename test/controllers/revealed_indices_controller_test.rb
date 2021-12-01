require "test_helper"

class RevealedIndicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @revealed_index = revealed_indices(:one)
  end

  test "should get index" do
    get revealed_indices_url
    assert_response :success
  end

  test "should get new" do
    get new_revealed_index_url
    assert_response :success
  end

  test "should create revealed_index" do
    assert_difference('RevealedIndex.count') do
      post revealed_indices_url, params: { revealed_index: { game_id: @revealed_index.game_id, index: @revealed_index.index } }
    end

    assert_redirected_to revealed_index_url(RevealedIndex.last)
  end

  test "should show revealed_index" do
    get revealed_index_url(@revealed_index)
    assert_response :success
  end

  test "should get edit" do
    get edit_revealed_index_url(@revealed_index)
    assert_response :success
  end

  test "should update revealed_index" do
    patch revealed_index_url(@revealed_index), params: { revealed_index: { game_id: @revealed_index.game_id, index: @revealed_index.index } }
    assert_redirected_to revealed_index_url(@revealed_index)
  end

  test "should destroy revealed_index" do
    assert_difference('RevealedIndex.count', -1) do
      delete revealed_index_url(@revealed_index)
    end

    assert_redirected_to revealed_indices_url
  end
end
