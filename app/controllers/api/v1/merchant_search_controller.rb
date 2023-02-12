class Api::V1::MerchantSearchController < ApplicationController

  def index
    # require 'pry'; binding.pry
    if params[:name]
      if !Merchant.all_names(params[:name]).nil?
        render json: MerchantSerializer.new(Merchant.all_names(params[:name]))
      else
        render json: { data: { errors: 'item not found'} }, status: 404
      end
    end
  end

  def show
   if params[:name]
      if !Merchant.search_one_name(params[:name]).nil?
        render json: MerchantSerializer.new(Merchant.search_one_name(params[:name]))
      else
        render json: { data: { errors: 'item not found'} }, status: 404
      end
    end
  end
  #   search_params = params[:name]
  #   merchant = Merchant.where("name ILIKE ?", "%#{search_params}%").order(:name).first
  #   if merchant != nil
  #     render json: MerchantSerializer.new(merchant)
  #   else
  #     render json: {data: {errors: "No match found"}}, status: 404
  #   end
  # end


end