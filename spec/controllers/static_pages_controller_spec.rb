require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "GET #login" do
    it "returns http success" do
      get :login
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #main" do
    it "returns http success" do
      get :main
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #settings" do
    it "returns http success" do
      get :settings
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #size" do
    it "returns http success" do
      get :size
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #rule" do
    it "returns http success" do
      get :rule
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #game" do
    it "returns http success" do
      get :game
      expect(response).to have_http_status(:success)
    end
  end

end
