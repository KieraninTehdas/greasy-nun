require 'rails_helper'

RSpec.describe "TrackingPoints", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/tracking_points/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/tracking_points/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/tracking_points/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/tracking_points/update"
      expect(response).to have_http_status(:success)
    end
  end
end
