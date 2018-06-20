require 'rails_helper'

RSpec.describe ContactsController, type: :controller do

  describe "GET #input" do
    it "returns http success" do
      get :input
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #confirm" do
    it "returns http success" do
      get :confirm
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #send" do
    it "returns http success" do
      get :send
      expect(response).to have_http_status(:success)
    end
  end

end
