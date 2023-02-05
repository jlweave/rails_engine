require 'rails_helper'

describe "Items API" do
  describe "get all items" do
    it "returns a list of items" do
      create_list(:item, 5)

      get '/api/v1/items'

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items.count).to eq(5)

      items.each do |item|
      
        expect(item).to have_key(:name)
        expect(item[:name]).to be_a(String)

        expect(item).to have_key(:description)
        expect(item[:description]).to be_a(String)

        expect(item).to have_key(:unit_price)
        expect(item[:unit_price]).to be_a(Float)
      end
    end
  end

  describe "get one item" do
    it "return a single item" do
      id = create(:item).id

      get "/api/v1/items/#{id}"

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful

      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(Integer)

      expect(item).to have_key(:description)
      expect(item[:description]).to be_a(String)

      expect(item).to have_key(:unit_price)
      expect(item[:unit_price]).to be_a(Float)

    end
  end
  
  describe "create an item" do
    it "creates a new item " do
      merchant = create(:merchant).id
      item_params = ({
        name: "Tiramisù",
        description: "Vegetable Stock",
        unit_price: 81.83,
        merchant_id: merchant})

      headers = {"CONTENT_TYPE" => "application/json"}

      post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
      
      created_item = Item.last

      expect(response).to be_successful
      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])

    end
  end

  describe "edit an item" do
    it "can update an item that already exists" do
      id = create(:item).id
      previous_name = Item.last.name
      item_params = { name: "Risotto with Seafood" }
      headers = {"CONTENT_TYPE" => "application/json"}

      patch "/api/v1/items/#{id}", headers: headers, params: JSON.generate({item: item_params})
      item = Item.find_by(id: id)

      expect(response).to be_successful
      expect(item.name).to_not eq(previous_name)
      expect(item.name).to eq("Risotto with Seafood")
    end
  end

  describe "delete an item" do
    it "can destroy an existing item" do
     item = create(:item)

      expect(Item.count).to eq(1)

      delete "/api/v1/items/#{item.id}"

      expect(response).to be_successful
      expect(Item.count).to eq(0)
      expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "get all the merchant data for a given item ID" do
    it "get the merchant data for a given item ID" do
      item = create(:item).id
      create_list(:merchant, 7, item_ids: item)
require 'pry'; binding.pry
      get "/api/v1/items/#{item}/merchants"

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(merchants.count).to eq(8)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(Integer)
require 'pry'; binding.pry
        expect(merchant).to have_key(:name)
        expect(merchant[:name]).to be_a(String)   
      end
    end
  end
end