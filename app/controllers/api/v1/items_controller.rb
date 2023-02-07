class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    # require 'pry'; binding.pry
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(Item.create(item_params)), status: 201
    else
      render json: {errors: "Item was not created"}, status: 404
    end
  end

  def update
    if Item.update(params[:id], item_params).save&&Item.exists?(params[:id])
      render json: ItemSerializer.new(Item.update(params[:id], item_params))
    else
      render json: {errors: "Item was not created"}, status: 404
    end
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  private

    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
    end
end