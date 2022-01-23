require 'rails_helper'

RSpec.describe 'Clients', type: :request do
  include ApiAsJsonHelper

  describe 'GET /api/v1/clients' do
    let!(:clients) { create_list(:client, 2) }

    context 'with authentication' do
      before do
        get api_v1_clients_path, headers: authentication_headers
      end

      it 'should return status 200 :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return the clients' do
        expect(json_parse).to eq([
          client_as_json(clients.first),
          client_as_json(clients.last)
        ])
      end
    end

    context 'no authentication' do
      let(:client) { create(:client) }

      before do
        get api_v1_client_path(client.id)
      end

      it 'should return status 401 :unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'must return message of unauthorized' do
        expect(json_parse).to eq({
          'errors' => ['You need to sign in or sign up before continuing.']
        })
      end
    end
  end

  describe 'GET /api/v1/clients/:id' do
    let(:client) { create(:client) }

    context 'with authentication' do
      before do 
        get api_v1_client_path(client.id), headers: authentication_headers
      end

      it 'should return status 200 :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return the client' do
        expect(json_parse).to eq(client_as_json(client))
      end
    end

    context 'no authentication' do
      before do 
        get api_v1_client_path(client.id)
      end

      it 'should return status 401 :unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'must return message of unauthorized' do
        expect(json_parse).to eq(
          {'errors' => ['You need to sign in or sign up before continuing.']}
        )
      end
    end
  end

  describe 'POST /api/v1/clients' do
    let(:address) { create(:address) }
    let(:client_params) { JSON.parse(build(:client, address: address).to_json) }

    context 'with authentication' do
      context 'with valid parameters' do
        before do
          post api_v1_clients_path, params: { clients: client_params }, 
          headers: authentication_headers
        end

        it 'should return status 201 :created' do
          expect(response).to have_http_status(:created)
        end
  
        it 'must return the correct data' do
          expect(json_parse).to include(
            'id', 'full_name', 'cpf', 'address_id'
          )
        end
      end

      context 'with invalid parameters' do
        before do
          post api_v1_clients_path, params: { clients: { street: '' } }, 
          headers: authentication_headers
        end

        it 'should return status 422 :unprocessable_entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should return validation errors' do
          expect(json_parse).to include(
            {
              'full_name' => [
                "can't be blank"
              ],
              'cpf' => [
                'is invalid', "can't be blank"
              ],
              'address' => [
                'must exist'
              ]
            }
          )
        end
      end
    end

    context 'no authentication' do
      let(:address) { create(:address) }
      let(:client_params) { JSON.parse(build(:client, address: address).to_json) }

      before do
        post api_v1_clients_path, params: { clients: client_params }
      end

      context 'with valid parameters' do
        it 'should return status 401 :unauthorized' do
          expect(response).to have_http_status(:unauthorized)
        end
  
        it 'must return message of unauthorized' do
          expect(json_parse).to eq(
            {"errors" => ["You need to sign in or sign up before continuing."]}
          )
        end
      end

      context 'with invalid parameters' do
        it 'should return status 401 :unauthorized' do
          expect(response).to have_http_status(:unauthorized)
        end
  
        it 'must return message of unauthorized' do
          expect(json_parse).to eq({
            'errors' => ['You need to sign in or sign up before continuing.']
          })
        end
      end
    end
  end

  describe 'UPDATE /api/v1/clients/:id' do
    context 'with authentication' do
      context 'with valid parameters' do
        let(:client) { create(:client) }

        before do
          put api_v1_client_path(client.id), headers: authentication_headers,
          params: { 'clients' => { 'full_name': 'Arnold Schwarzenegger' } }
        end

        it 'should return status 200 :ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'must change the parameter' do
          client.reload

          expect(json_parse['full_name']).to eq(client_as_json(client)['full_name'])
        end
      end

      context 'with invalid parameters' do
        let(:client) { create(:client) }

        before do
          put api_v1_client_path(client.id), headers: authentication_headers,
          params: { clients: { 'full_name': '' } }
        end

        it 'should return status 422 :unprocessable_entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should return error message' do
          expect(json_parse).to eq({'full_name'=>["can't be blank"]})
        end
      end
    end

    context 'no authentication' do
      context 'with valid parameters' do
        let(:client) { create(:client) }

        before do
          put api_v1_client_path(client.id), params: { 'street': 'Rua Baker' }
        end

        it 'should return status 401 :unauthorized' do
          expect(response).to have_http_status(:unauthorized)
        end
  
        it 'must return message of unauthorized' do
          expect(json_parse).to eq(
            {"errors" => ["You need to sign in or sign up before continuing."]}
          )
        end
      end

      context 'with invalid parameters' do
        let(:client) { create(:client) }

        before do
          put api_v1_client_path(client.id), params: { 'street': 'Rua Baker' }
        end

        it 'should return status 401 :unauthorized' do
          expect(response).to have_http_status(:unauthorized)
        end
  
        it 'must return message of unauthorized' do
          expect(json_parse).to eq({
            'errors' => ['You need to sign in or sign up before continuing.']
          })
        end
      end
    end
  end

  describe 'DELETE /api/v1/clients/:id' do
    context 'with authentication' do
      let!(:client) { create(:client) }
      let(:id) { client.id }

      before do
        delete api_v1_client_path(client.id), headers: authentication_headers
      end

      it '' do
        expect { Client.find(id) }.to raise_error {
          ActiveRecord::RecordInvalid
        }
      end
    end

    context 'no authentication' do
      let(:client) { create(:client) }

      before do
        delete api_v1_client_path(client.id)
      end

      it 'should return status 401 :unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end

      it 'must return message of unauthorized' do
        expect(json_parse).to eq({
          'errors' => ['You need to sign in or sign up before continuing.']
        })
      end
    end
  end
end
