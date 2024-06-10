require 'rails_helper'

RSpec.describe ChatsController, type: :controller do
  let(:application) { Application.create!(name: 'Test Application', token: SecureRandom.hex) }

  describe "GET #index" do
    it "returns a success response" do
      chat = application.chats.create!(number: 1)
      get :index, params: { application_token: application.token }
      expect(response).to be_successful
      expect(JSON.parse(response.body).first['chat_number']).to eq(chat.number)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Chat" do
        expect {
          post :create, params: { application_token: application.token }
        }.to change(Chat, :count).by(1)
      end

      it "renders a JSON response with the new chat" do
        post :create, params: { application_token: application.token }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)['chat_number']).to eq(1)
      end
    end

    context "with invalid application token" do
      it "returns a not found response" do
        post :create, params: { application_token: 'invalid' }
        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "GET #show" do
    context "with valid chat number" do
      it "returns the chat" do
        chat = application.chats.create!(number: 1)
        get :show, params: { application_token: application.token, number: chat.number }
        expect(response).to be_successful
        expect(JSON.parse(response.body)['chat_number']).to eq(chat.number)
      end
    end

    context "with invalid chat number" do
      it "returns a not found response" do
        get :show, params: { application_token: application.token, number: 999 }
        expect(response).to have_http_status(:not_found)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
