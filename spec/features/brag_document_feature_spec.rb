require 'rails_helper'

RSpec.feature "Brag Document page", type: :feature do
  scenario "User navigates to the brag document page and back" do
    visit quests_path

    click_link "My Brag Document"

    expect(page).to have_content "PLEUM'S JOURNEY"
    expect(page).to have_content "My 2025 Goals & Dreams"

    click_link "Back to Quests"

    expect(page).to have_content "Pleum"
    expect(page).to have_content "My Quests"
  end
end
