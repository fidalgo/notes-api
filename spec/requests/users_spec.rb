require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /api/v1/users" do
    it "List users" do
      get api_v1_users_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/user/" do
    it "Get valid user" do
      user = create(:user)
      get api_v1_users_path(user)
      expect(response).to have_http_status(200)
    end
  end

end
