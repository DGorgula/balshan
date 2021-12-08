require "application_system_test_case"

class MismatchedIndicesTest < ApplicationSystemTestCase
  setup do
    @mismatched_index = mismatched_indices(:one)
  end

  test "visiting the index" do
    visit mismatched_indices_url
    assert_selector "h1", text: "Mismatched Indices"
  end

  test "creating a Mismatched index" do
    visit mismatched_indices_url
    click_on "New Mismatched Index"

    fill_in "Game", with: @mismatched_index.game_id
    fill_in "Index", with: @mismatched_index.index
    fill_in "Step", with: @mismatched_index.step_id
    click_on "Create Mismatched index"

    assert_text "Mismatched index was successfully created"
    click_on "Back"
  end

  test "updating a Mismatched index" do
    visit mismatched_indices_url
    click_on "Edit", match: :first

    fill_in "Game", with: @mismatched_index.game_id
    fill_in "Index", with: @mismatched_index.index
    fill_in "Step", with: @mismatched_index.step_id
    click_on "Update Mismatched index"

    assert_text "Mismatched index was successfully updated"
    click_on "Back"
  end

  test "destroying a Mismatched index" do
    visit mismatched_indices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Mismatched index was successfully destroyed"
  end
end
