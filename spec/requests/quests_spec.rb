require 'rails_helper'

RSpec.describe "Quests", type: :request do
  let!(:quest) { Quest.create!(name: "Test Quest", status: false) }

  describe "GET /index" do
    it "returns a successful response" do
      get quests_path
      expect(response).to have_http_status(200)
      expect(response.body).to include("Test Quest")
    end
  end

  describe "POST /create" do
    context "with valid params" do
      it "creates a new quest and responds to HTML" do
        expect {
          post quests_path, params: { quest: { name: "New Quest", status: false } }
        }.to change(Quest, :count).by(1)
        expect(response).to redirect_to(quests_path)
      end

      it "creates a new quest and responds to Turbo Stream" do
        expect {
          post quests_path, params: { quest: { name: "Turbo Quest", status: false } }, headers: { "ACCEPT" => "text/vnd.turbo-stream.html" }
        }.to change(Quest, :count).by(1)
        expect(response.content_type).to eq "text/vnd.turbo-stream.html; charset=utf-8"
      end
    end

    context "with invalid params" do
      it "does not create a quest" do
        expect {
          post quests_path, params: { quest: { name: "", status: false } }
        }.not_to change(Quest, :count)
        expect(response).to have_http_status(:unprocessable_content)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested quest and redirects HTML" do
      expect {
        delete quest_path(quest)
      }.to change(Quest, :count).by(-1)
      expect(response).to redirect_to(root_path)
    end

    it "destroys the quest and responds to Turbo Stream" do
      expect {
        delete quest_path(quest), headers: { "ACCEPT" => "text/vnd.turbo-stream.html" }
      }.to change(Quest, :count).by(-1)
      expect(response.content_type).to eq "text/vnd.turbo-stream.html; charset=utf-8"
    end
  end

  describe "PATCH /toggle" do
    it "toggles the quest status for HTML request" do
      expect {
        patch toggle_quest_path(quest)
      }.to change { quest.reload.status }.from(false).to(true)
      expect(response).to redirect_to(quests_path)
    end

    it "toggles the quest status for Turbo Stream" do
      expect {
        patch toggle_quest_path(quest), headers: { "ACCEPT" => "text/vnd.turbo-stream.html" }
      }.to change { quest.reload.status }.from(false).to(true)
      expect(response.content_type).to eq "text/vnd.turbo-stream.html; charset=utf-8"
    end
  end
end
