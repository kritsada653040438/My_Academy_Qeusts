require 'rails_helper'

RSpec.describe "BragDocuments", type: :request do
  describe "GET /brag_document" do
    it "returns a successful response" do
      get brag_document_path
      expect(response).to be_successful
    end
  end
end
