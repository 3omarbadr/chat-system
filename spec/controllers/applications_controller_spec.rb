require 'rails_helper'

RSpec.describe ApplicationsController, type: :controller do
  let(:valid_attributes) {
    { name: 'Test Application' }
  }

  let(:invalid_attributes) {
    { name: '' }
  }

  let(:application) {
    Application.create!(name: 'Test Application', token: SecureRandom.hex)
  }

#   describe "GET #index" do
#     it "returns a success response" do
#       application
#       get :index
#       expect(response).to be_successful
#     end
#   end

  describe "GET #show" do
    context "with valid token" do
      it "returns the application" do
        get :show, params: { token: application.token }
        expect(response).to be_successful
        expect(JSON.parse(response.body)['name']).to eq('Test Application')
      end
    end

    context "with invalid token" do
      it "returns a not found response" do
        get :show, params: { token: 'invalid' }
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Application" do
        expect {
          post :create, params: { application: valid_attributes }
        }.to change(Application, :count).by(1)
      end

      it "renders a JSON response with the new application" do
        post :create, params: { application: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json; charset=utf-8')
        expect(JSON.parse(response.body)['name']).to eq('Test Application')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new application" do
        post :create, params: { application: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: 'Updated Application' }
      }

      it "updates the requested application" do
        put :update, params: { token: application.token, application: new_attributes }
        application.reload
        expect(application.name).to eq('Updated Application')
      end

      it "renders a JSON response with the application" do
        put :update, params: { token: application.token, application: valid_attributes }
        expect(response).to be_successful
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the application" do
        put :update, params: { token: application.token, application: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end
end
