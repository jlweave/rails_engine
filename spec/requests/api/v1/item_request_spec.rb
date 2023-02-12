require 'rails_helper'

describe "Items API" do
  describe "get all items" do
    it "returns a list of items" do
      create_list(:item, 5)
      
      get '/api/v1/items'
      
      expect(response).to be_successful
      
      # require 'pry'; binding.pry
      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(5)

      items[:data].each do |item|
   
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)

      expect(item).to have_key(:type)
      expect(item[:type]).to be_a(String)

      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)

      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)

      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
      end
    end
  end

  describe "get one item" do
    it "return a single item" do
      items = create(:item).id

      get "/api/v1/items/#{items}"

      item = JSON.parse(response.body, symbolize_names: true)
# require 'pry'; binding.pry
      expect(response).to be_successful

      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to be_a(String)

      expect(item[:data]).to have_key(:type)
      expect(item[:data][:type]).to be_a(String)

      expect(item[:data]).to have_key(:attributes)
      expect(item[:data][:attributes]).to be_a(Hash)

      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to be_a(String)

      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes][:description]).to be_a(String)

      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes][:unit_price]).to be_a(Float)

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

  describe "get merchant data for a given item ID" do
    it "get the merchant data for a given item ID" do
      merchant = create(:merchant)
      items = create_list(:item, 2, merchant_id: merchant.id)
      item = items.first

      get("/api/v1/items/#{item.id}/merchant")
      
      merchants = JSON.parse(response.body, symbolize_names: true)
    
      expect(response).to be_successful
      expect(merchants[:data].count).to eq(3)

      expect(merchants[:data]).to have_key(:id)
      expect(merchants[:data][:id]).to eq("10")
      expect(merchants[:data][:attributes]).to have_key(:name)
    end
  end
end