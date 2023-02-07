class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    if params[:item_id]
      item = Item.find(params[:item_id])
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
    else
      render json: MerchantSerializer.new(Merchant.find(params[:id]))
      # render json: {errors: "merchant does not exist" }, status: 404
    end
  end
end