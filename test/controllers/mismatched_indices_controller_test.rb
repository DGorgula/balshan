require "test_helper"

class MismatchedIndicesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @mismatched_index = mismatched_indices(:one)
  end

  test "should get index" do
    get mismatched_indices_url
    assert_response :success
  end

  test "should get new" do
    get new_mismatched_index_url
    assert_response :success
  end

  test "should create mismatched_index" do
    assert_difference('MismatchedIndex.count') do
      post mismatched_indices_url, params: { mismatched_index: { game_id: @mismatched_index.game_id, index: @mismatched_index.index, step_id: @mismatched_index.step_id } }
    end

    assert_redirected_to mismatched_index_url(MismatchedIndex.last)
  end

  test "should show mismatched_index" do
    get mismatched_index_url(@mismatched_index)
    assert_response :success
  end

  test "should get edit" do
    get edit_mismatched_index_url(@mismatched_index)
    assert_response :success
  end

  test "should update mismatched_index" do
    patch mismatched_index_url(@mismatched_index), params: { mismatched_index: { game_id: @mismatched_index.game_id, index: @mismatched_index.index, step_id: @mismatched_index.step_id } }
    assert_redirected_to mismatched_index_url(@mismatched_index)
  end

  test "should destroy mismatched_index" do
    assert_difference('MismatchedIndex.count', -1) do
      delete mismatched_index_url(@mismatched_index)
    end

    assert_redirected_to mismatched_indices_url
  end
end
