require 'rails_helper'

describe "Merchants API" do
  describe "get all merchants" do
    it "returns all merchants " do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(3)

      merchants[:data].each do |merchant|
        # require 'pry'; binding.pry
        # expect(merchant).to have_key(:id)
        # expect(merchant[:id]).to be_a(String)

        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a(String)
  
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end
  end

  describe "get one merchant" do
    it "returns on merchant by their id" do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to be_a(String)
# require 'pry'; binding.pry
      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end
  end

  describe " get all items for a given merchant ID" do
    it "get all items for a given merchant" do
      # require 'pry'; binding.pry
      merchant = create(:merchant).id
      # require 'pry'; binding.pry
      create_list(:item, 7, merchant_id: merchant)

      get "/api/v1/merchants/#{merchant}/items"

      items = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(items[:data].count).to eq(7)

      items[:data].each do |item|
        # require 'pry'; binding.pry
        expect(item).to have_key(:id)
        expect(item[:id]).to be_a(String)

        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)

        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)

        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)

      end
    end
    
    xit "happy path: get correct error for incorrect amount" do
      

    end

    xit "sad path: bad integer id returns 404" do

      
    end
  end
end
