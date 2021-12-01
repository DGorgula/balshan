require "application_system_test_case"

class StepsTest < ApplicationSystemTestCase
  setup do
    @step = steps(:one)
  end

  test "visiting the index" do
    visit steps_url
    assert_selector "h1", text: "Steps"
  end

  test "creating a Step" do
    visit steps_url
    click_on "New Step"

    fill_in "Existlettercount", with: @step.existLetterCount
    fill_in "Game", with: @step.game_id
    fill_in "Inplacelettercount", with: @step.inPlaceLetterCount
    fill_in "Stepword", with: @step.stepWord
    click_on "Create Step"

    assert_text "Step was successfully created"
    click_on "Back"
  end

  test "updating a Step" do
    visit steps_url
    click_on "Edit", match: :first

    fill_in "Existlettercount", with: @step.existLetterCount
    fill_in "Game", with: @step.game_id
    fill_in "Inplacelettercount", with: @step.inPlaceLetterCount
    fill_in "Stepword", with: @step.stepWord
    click_on "Update Step"

    assert_text "Step was successfully updated"
    click_on "Back"
  end

  test "destroying a Step" do
    visit steps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Step was successfully destroyed"
  end
end
