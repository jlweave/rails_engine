class Api::V1::MerchantSearchController < ApplicationController

  def index
    # require 'pry'; binding.pry
    search_params = params[:name]
    merchant = Merchant.where("name ILIKE ?", "%#{search_params}%").order(:name).first
    if merchant != nil
      render json: MerchantSerializer.new(merchant)
    else
      render json: {data: {errors: "No match found"}}, status: 404
    end
  end
end