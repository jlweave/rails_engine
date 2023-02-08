class Api::V1::MerchantSearchController < ApplicationController

  def index
    search_params = params[:name]
    merchant = Merchant.where("name ILIKE ?", "%#{search_params}%").order(:name).first
    # require 'pry'; binding.pry
    if merchant != nil
      render json: MerchantSerializer.new(merchant)
      # require 'pry'; binding.pry
    else
      render json: {data: {errors: "No match found"}}, status: 404
    end
  end


end