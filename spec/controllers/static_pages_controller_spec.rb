require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  # before do
  #   driven_by(:rack_test)
  #   existing_user = User.create(name: 'Frank Sinatra', password: 'franky', password_confirmation: 'franky')
  #   visit '/'
  #   fill_in 'Name', with: 'Frank Sinatra'
  #   fill_in 'Password', with: 'franky'
  #   click_on 'Log in'
  # end

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
