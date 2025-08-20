require 'rails_helper'

RSpec.feature "Brag Document page", type: :feature do
  context "when navigating to and from the brag document page" do
    before do
      go_to_home_page
    end

    it "allows user to navigate to the brag document page and back" do
      click_my_brag_document_button
      should_see_brag_document_details

      click_back_to_quests_button
      should_see_quests_page_details
    end
  end

  def go_to_home_page
    visit quests_path
  end

  def click_my_brag_document_button
    click_link "My Brag Document"
  end

  def should_see_brag_document_details
    expect(page).to have_content "PLEUM'S JOURNEY"
    expect(page).to have_content "My 2025 Goals & Dreams"
    expect(page).to have_content "Future Software Developer"
    expect(page).to have_content "Dream Chaser"
    expect(page).to have_content "English Mastery"
    expect(page).to have_content "Academic Achievement"
    expect(page).to have_content "Professional Journey with ODDS"
    expect(page).to have_content "Internship Success"
    expect(page).to have_content "Scrum Master Excellence"
    expect(page).to have_content "We believe software development should be joyful and advocate deliberate practice."
    expect(page).to have_content "- PLEUM 2025"
  end

  def click_back_to_quests_button
    click_link "Back to Quests"
  end

  def should_see_quests_page_details
    expect(page).to have_content "Quests"
    expect(page).to have_field "What's your next quest?"
  end
end
