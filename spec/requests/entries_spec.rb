require 'rails_helper'

RSpec.describe "Entries", type: :request do
  describe "GET /entries" do
    it "List entries" do
      note = create(:note)
      get api_v1_note_entries_path(note)
      expect(response).to have_http_status(200)
    end
  end
end
