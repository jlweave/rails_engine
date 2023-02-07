class Api::V1::ItemMerchantsController < ApplicationController

  def index
    if Item.exists?(params[:item_id])
      item = Item.find(params[:item_id])
      merchant = item.merchant
      x = render json: MerchantSerializer.new(merchant)
      # require 'pry'; binding.pry
    else
      render json: {errors: "Not found" }, status: 404
    end 
  end 
end