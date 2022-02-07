class Api::V1::DevicesController < ApplicationController
  before_action :set_device, only: [:show, :update, :destroy]
  before_action :authenticate_api_user!

  def index
    @devices = Device.all

    render json: @devices
  end

  def show
    render json: @device
  end

  def create
    @device = Device.new(device_params)
    if @device.save
      render json: @device, status: :created
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  def update
    if @device.update(device_params)
      render json: @device
    else
      render json: @device.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @device.destroy
  end

  private

  def set_device
    @device = Device.find(params[:id])
  end

  def device_params
    params.require(:devices).permit(:name, :brand, :model, :device_type_id)
  end
end
