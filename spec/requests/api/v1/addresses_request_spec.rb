require 'rails_helper'

RSpec.describe 'Addresses', type: :request do
  include ApiAsJsonHelper

  describe 'GET /addresses/:id' do
    let(:address) { create(:address) }

    context 'with authentication' do
      before do 
        get api_v1_address_path(address.id), headers: authentication_headers
      end

      it 'should return status 200 :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return the address' do
        expect(json_parse).to eq(address_as_json(address))
      end
    end

    context 'no authentication' do
      before do 
        get api_v1_address_path(address.id)
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
  end

  describe 'POST /addresses' do
    let!(:address_params) { JSON.parse(attributes_for(:address).to_json) }

    context 'with authentication' do
      context 'with valid parameters' do
        before do
          post api_v1_addresses_path, params: { addresses: address_params }, 
          headers: authentication_headers
        end

        it 'should return status 201 :created' do
          expect(response).to have_http_status(:created)
        end
  
        it 'must return the correct data' do
          expect(json_parse).to include(address_params)
        end
      end

      context 'with invalid parameters' do
        before do
          post api_v1_addresses_path, params: { addresses: { street: '' } }, 
          headers: authentication_headers
        end

        it 'should return status 422 :unprocessable_entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should return validation errors' do
          expect(json_parse).to include(
            {
              "street" => [
                "can't be blank"
              ],
              "district" => [
                "can't be blank"
              ],
              "complement" => [
                "can't be blank"
              ]
            }
          )
        end
      end
    end

    context 'no authentication' do
      before do
        post api_v1_addresses_path, params: { addresses: address_params }
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
          expect(json_parse).to eq(
            {"errors" => ["You need to sign in or sign up before continuing."]}
          )
        end
      end
    end
  end

  describe 'UPDATE /addresses/:id' do
    let(:address) { create(:address) }

    context 'with authentication' do
      context 'with valid parameters' do
        before do
          put api_v1_address_path(address.id), headers: authentication_headers,
          params: { 'addresses' => { 'street': 'Rua Baker' } }
        end

        it 'should return status 200 :ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'must change the parameter' do
          address.reload

          expect(json_parse).to eq(address_as_json(address))
        end
      end

      context 'with invalid parameters' do
        it 'should return status 422 :unprocessable_entity' do
          # TO DO: encontrar forma melhor de testar este caso. 01/12/2021 21:57
          expect { 
            put api_v1_address_path(address.id), headers: authentication_headers,
            params: { addresses: { 'street': '' } }
          }.to raise_error {  ActiveRecord::RecordInvalid }
        end
      end
    end

    context 'no authentication' do
      context 'with valid parameters' do
        before do
          put api_v1_address_path(address.id), params: { 'street': 'Rua Baker' }
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
        before do
          put api_v1_address_path(address.id), params: { 'street': 'Rua Baker' }
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
    end
  end
end
