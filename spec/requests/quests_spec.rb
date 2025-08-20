require 'rails_helper'

RSpec.describe "Quests", type: :request do
  describe "GET /quests" do
    it "returns a successful response" do
      get quests_path
      expect(response).to be_successful
    end
  end

  describe "POST /quests" do
    context "with valid parameters" do
      it "creates a new quest" do
        expect {
          post quests_path, params: { quest: { name: "Test Quest" } }
        }.to change(Quest, :count).by(1)
      end

      it "creates two new quests" do
        expect {
          post quests_path, params: { quest: { name: "Another Test Quest" } }
          post quests_path, params: { quest: { name: "Yet Another Test Quest" } }
        }.to change(Quest, :count).by(2)
      end
    end

    context "with invalid parameters" do
      it "does not create a new quest" do
        expect {
          post quests_path, params: { quest: { name: "" } }
        }.to change(Quest, :count).by(0)
      end
    end
  end

  describe "PATCH /quests/:id/toggle" do
    let(:quest) { create(:quest) }

    it "toggles the quest status" do
      patch toggle_quest_path(quest)
      quest.reload
      expect(quest.status).to be(true)
    end
  end

  describe "DELETE /quests/:id" do
    let!(:quest) { create(:quest) }

    it "destroys the quest" do
      expect {
        delete quest_path(quest)
      }.to change(Quest, :count).by(-1)
    end
  end
end
