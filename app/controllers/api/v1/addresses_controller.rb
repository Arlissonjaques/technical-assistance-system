class Api::V1::AddressesController < ApplicationController
  before_action :set_address, only: [:show, :update]
  before_action :authenticate_api_user!

  def show
    render json: @address
  end

  def create
    @address = Address.new(address_params)

    if @address.save
      render json: @address, status: :created
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def update
    if @address.update!(address_params)
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:addresses).permit(:street, :district, :number, :complement)
  end
end
