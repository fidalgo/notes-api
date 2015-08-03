require 'rails_helper'

RSpec.describe "Notes", type: :request do

  describe "All API interactions" do
    # TODO: Add all possible API interactions
    skip("Add all possible API interactions")
  end

  describe "GET /notes" do
    it "List notes" do
      get api_v1_notes_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/note/" do
    it "Get valid user" do
      note = create(:note)
      get api_v1_notes_path(note)
      expect(response).to have_http_status(200)
    end
  end

end
