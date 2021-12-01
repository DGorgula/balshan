require "application_system_test_case"

class RevealedIndicesTest < ApplicationSystemTestCase
  setup do
    @revealed_index = revealed_indices(:one)
  end

  test "visiting the index" do
    visit revealed_indices_url
    assert_selector "h1", text: "Revealed Indices"
  end

  test "creating a Revealed index" do
    visit revealed_indices_url
    click_on "New Revealed Index"

    fill_in "Game", with: @revealed_index.game_id
    fill_in "Index", with: @revealed_index.index
    click_on "Create Revealed index"

    assert_text "Revealed index was successfully created"
    click_on "Back"
  end

  test "updating a Revealed index" do
    visit revealed_indices_url
    click_on "Edit", match: :first

    fill_in "Game", with: @revealed_index.game_id
    fill_in "Index", with: @revealed_index.index
    click_on "Update Revealed index"

    assert_text "Revealed index was successfully updated"
    click_on "Back"
  end

  test "destroying a Revealed index" do
    visit revealed_indices_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Revealed index was successfully destroyed"
  end
end
