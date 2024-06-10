require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:application) { Application.create!(name: 'Test Application', token: SecureRandom.hex) }
  let(:chat) { application.chats.create!(number: 1) }

  describe "GET #index" do
    it "returns a success response" do
      message = chat.messages.create!(number: 1, body: 'Hello World')
      get :index, params: { application_token: application.token, chat_number: chat.number }
      expect(response).to be_successful
      expect(JSON.parse(response.body).first['message_number']).to eq(message.number)
      expect(JSON.parse(response.body).first['message_body']).to eq(message.body)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Message" do
        expect {
          post :create, params: { application_token: application.token, chat_number: chat.number, message: { body: 'Hello' } }
        }.to change(Message, :count).by(1)
      end

      it "renders a JSON response with the new message" do
        post :create, params: { application_token: application.token, chat_number: chat.number, message: { body: 'Hello' } }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)['message_number']).to eq(1)
        expect(JSON.parse(response.body)['message_body']).to eq('Hello')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new message" do
        post :create, params: { application_token: application.token, chat_number: chat.number, message: { body: '' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end


  describe "GET #search" do
    it "returns messages matching the query" do
      message1 = chat.messages.create!(number: 1, body: 'Hello World')
      message2 = chat.messages.create!(number: 2, body: 'Goodbye World')
      get :search, params: { application_token: application.token, chat_number: chat.number, q: 'Hello' }
      expect(response).to be_successful
      expect(JSON.parse(response.body).first['message_body']).to eq(message1.body)
    end
  end
end
