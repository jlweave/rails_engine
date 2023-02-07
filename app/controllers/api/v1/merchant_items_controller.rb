class Api::V1::MerchantItemsController < ApplicationController

  def index
    if params[:item_id]
      item = Item.find(params[:item_id])  
        merchant = Merchant.find(item.merchant_id)
        render json: ItemSerializer.new(merchant.items)
    else
      if Merchant.exists?(params[:merchant_id])
        merchant = Merchant.find(params[:merchant_id])
        x = render json: ItemSerializer.new(merchant.items)
        # require 'pry'; binding.pry
      else
        render json: {errors: "merchant does not exist" }, status: 404
      end
    end
  end
end