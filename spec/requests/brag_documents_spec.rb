require 'rails_helper'

RSpec.describe "BragDocuments", type: :request do
  describe "GET /brag_document" do
    it "returns a successful response" do
      get brag_document_path
      expect(response).to have_http_status(200)
    end
  end
end
