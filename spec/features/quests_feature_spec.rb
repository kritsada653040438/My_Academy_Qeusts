require 'rails_helper'

RSpec.feature "Quests management", type: :feature do
  context "when a user is on the home page" do
    before do
      Quest.destroy_all
      go_to_home_page
    end

    it "allows user to create a new quest" do
      fill_in_the_quest_name_field_with "My New Quest"
      click_the_add_quest_button
      should_see_the_quest_name "My New Quest"
    end

    it "allows user to toggle quest status" do
      create_quest_for_test("Quest to Toggle")
      should_see_the_quest_name "Quest to Toggle"

      toggle_the_quest_status "Quest to Toggle"
      should_see_quest_as_completed "Quest to Toggle"
    end

    it "allows user to delete a quest" do
      create_quest_for_test("Quest to Delete")
      should_see_the_quest_name "Quest to Delete"

      click_the_delete_quest_button
      should_not_see_the_quest "Quest to Delete"
    end

    it "displays an error when creating an invalid quest" do
      fill_in_the_quest_name_field_with ""
      click_the_add_quest_button
      should_see_error_message "Name cannot be empty, please provide a quest name."
    end
  end

  def go_to_home_page
    visit quests_path
  end

  def fill_in_the_quest_name_field_with(name)
    fill_in "What's your next quest?", with: name
  end

  def click_the_add_quest_button
    find('[data-test-id="add-quest-button"]').click
  end

  def should_see_the_quest_name(name)
    expect(page).to have_content name
  end

  def toggle_the_quest_status(name)
    find("[data-test-id^=\"toggle-quest-\"]").click
  end

  def should_see_quest_as_completed(name)
    expect(page).to have_css('span.line-through', text: name)
  end

  def click_the_delete_quest_button
    find('[data-test-id^="delete-quest-"]').click
  end

  def should_not_see_the_quest(name)
    expect(page).to_not have_content name
  end

  def should_see_error_message(message)
    expect(page).to have_content message
  end

  # Helper to create a quest for testing purposes
  def create_quest_for_test(name)
    fill_in_the_quest_name_field_with name
    click_the_add_quest_button
    should_see_the_quest_name name
  end
end
