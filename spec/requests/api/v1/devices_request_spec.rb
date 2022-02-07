require 'rails_helper'

RSpec.describe 'Api::V1::Devices', type: :request do
  include ApiAsJsonHelper

  describe 'GET /api/v1/devices' do
    let!(:devices) { create_list(:device, 2) }

    context 'with authentication' do
      before do
        get api_v1_devices_path, headers: authentication_headers
      end

      it 'should return status 200 :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return the devices' do
        expect(json_parse).to eq([
          device_as_json(devices.first),
          device_as_json(devices.last)
        ])
      end
    end

    context 'no authentication' do
      let(:device) { create(:device) }

      before do
        get api_v1_devices_path(device.id)
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

  describe 'GET /api/v1/devices/:id' do
    let(:device) { create(:device) }

    context 'with authentication' do
      before do 
        get api_v1_device_path(device.id), headers: authentication_headers
      end

      it 'should return status 200 :ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'must return the device' do
        expect(json_parse).to eq(device_as_json(device))
      end
    end

    context 'no authentication' do
      before do 
        get api_v1_device_path(device.id)
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

  describe 'POST /api/v1/devices' do
    let(:device_type) { create(:device_type) }
    let(:device_params) do
      JSON.parse(build(:device, device_type: device_type).to_json)
    end

    context 'with authentication' do
      context 'with valid parameters' do
        before do
          post api_v1_devices_path, params: { devices: device_params }, 
          headers: authentication_headers
        end

        it 'should return status 201 :created' do
          expect(response).to have_http_status(:created)
        end
  
        it 'must return the correct data' do
          expect(json_parse).to include(
            'id', 'name', 'model', 'brand', 'device_type_id'
          )
        end
      end

      context 'with invalid parameters' do
        before do
          post api_v1_devices_path, params: { devices: { name: '' } }, 
          headers: authentication_headers
        end

        it 'should return status 422 :unprocessable_entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should return validation errors' do
          expect(json_parse).to include(
            {
              'brand' => [
                "can't be blank"
              ],
              'device_type' => [
                'must exist'
              ],
              'model' => [
                "can't be blank"
              ],
              'name' => [
                "can't be blank"
              ]
            }
          )
        end
      end
    end

    context 'no authentication' do
      let(:device_type) { create(:device_type) }
      let(:device_params) do
        JSON.parse(build(:device, device_type: device_type).to_json)
      end

      before do
        post api_v1_devices_path,
        params: { devices: device_params }
      end

      context 'with valid parameters' do
        it 'should return status 401 :unauthorized' do
          expect(response).to have_http_status(:unauthorized)
        end
  
        it 'must return message of unauthorized' do
          expect(json_parse).to eq(
            {'errors' => ['You need to sign in or sign up before continuing.']}
          )
        end
      end

      context 'with invalid parameters' do
        before do
          post api_v1_devices_path,
          params: { devices: { name: '' } }
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

  describe 'UPDATE /api/v1/devices/:id' do
    context 'with authentication' do
      context 'with valid parameters' do
        let(:device) { create(:device) }

        before do
          put api_v1_device_path(device.id),
          headers: authentication_headers,
          params: { 'devices' => { 'name': 'J5 Prime' } }
        end

        it 'should return status 200 :ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'must change the parameter' do
          device.reload

          expect(json_parse['name']).to eq(
            device_as_json(device)['name']
          )
        end
      end

      context 'with invalid parameters' do
        let(:device) { create(:device) }

        before do
          put api_v1_device_path(device.id),
          headers: authentication_headers,
          params: { devices: { 'name': '' } }
        end

        it 'should return status 422 :unprocessable_entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'should return error message' do
          expect(json_parse).to eq({'name'=>["can't be blank"]})
        end
      end
    end

    context 'no authentication' do
      context 'with valid parameters' do
        let(:device) { create(:device) }

        before do
          put api_v1_device_path(device.id),
          params: { 'name': 'J5 Prime' }
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

      context 'with invalid parameters' do
        let(:device) { create(:device) }

        before do
          put api_v1_device_path(device.id),
          params: { 'name': 'J5 Prime' }
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

  describe 'DELETE /api/v1/devices/:id' do
    context 'with authentication' do
      let(:device) { create(:device) }
      let!(:id) { device.id }

      before do
        delete api_v1_device_path(device.id),
        headers: authentication_headers
      end

      it "shouldn't find the record" do
        expect { Device.find(id) }.to raise_error {
          ActiveRecord::RecordInvalid
        }
      end
    end

    context 'no authentication' do
      let(:device) { create(:device) }

      before do
        delete api_v1_device_path(device.id)
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
