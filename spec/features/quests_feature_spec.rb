require 'rails_helper'

RSpec.feature "Quests management", type: :feature do
  scenario "User creates a new quest and toggles its status" do
    visit quests_path

    fill_in "What's your next quest?", with: "Learn Capybara"
    find('[data-test-id="add-quest-button"]').click

    expect(page).to have_content "Learn Capybara"

    find('[data-test-id^="toggle-quest-"]').click
    expect(page).to have_css('span.line-through', text: "Learn Capybara")

    find('[data-test-id^="delete-quest-"]').click
    expect(page).to_not have_content "Learn Capybara"
  end

  scenario "User tries to create an invalid quest" do
    visit quests_path

    fill_in "What's your next quest?", with: ""
    find('[data-test-id="add-quest-button"]').click

    expect(page).to have_content "Name cannot be empty, please provide a quest name."
  end
end
