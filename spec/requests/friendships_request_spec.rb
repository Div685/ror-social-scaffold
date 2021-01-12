require 'rails_helper'

RSpec.describe "Friendships", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/friendships/index"
      expect(response).to have_http_status(:success)
    end
  end

end
