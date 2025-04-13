# spec/controllers/urls_controller_spec.rb

require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  let(:valid_url) { "http://example.com" }
  let(:invalid_url) { "invalid-url" }
  let(:existing_url) { Url.create(original: valid_url, short: "short123") }

  describe "GET #index" do
    it "returns all URLs" do
      existing_url 
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(1) 
    end
  end

  describe "POST #create" do
    context "when the URL is valid" do
      it "creates a new short URL" do
        expect {
          post :create, params: { original: valid_url }
        }.to change(Url, :count).by(1)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['original']).to eq(valid_url)
        expect(JSON.parse(response.body)['short']).not_to be_nil
      end
    end

    context "when the URL already exists" do
      it "does not create a new URL and returns the existing one" do
        post :create, params: { original: valid_url }
        post :create, params: { original: valid_url }

        expect(Url.count).to eq(1) 
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['original']).to eq(valid_url)
      end
    end

    context "when the URL is invalid" do
      it "returns an error message" do
        post :create, params: { original: invalid_url }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['error']).to eq('Invalid URL')
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the URL" do
      url_to_delete = Url.create(original: valid_url, short: "short123")
      expect {
        delete :destroy, params: { id: url_to_delete.id }
      }.to change(Url, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['message']).to eq('URL deleted successfully')
    end
  end

  describe "GET #redirect" do
    context "when the short URL exists" do
      it "redirects to the original URL" do
        get :redirect, params: { short: existing_url.short }
        expect(response).to redirect_to(valid_url)
      end
    end

    context "when the short URL does not exist" do
      it "returns a not found error" do
        get :redirect, params: { short: "nonexistent" }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Not Found')
      end
    end
  end
end
