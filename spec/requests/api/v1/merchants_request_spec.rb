require 'rails_helper'

describe "Merchants API" do
  describe "get all merchants" do
    it "returns all merchants " do
      create_list(:merchant, 3)

      get '/api/v1/merchants'

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants.count).to eq(3)

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_a(Integer)

        expect(merchant).to have_key(:name)
        expect(merchant[:name]).to be_a(String)
      end
    end
  end

  describe "get one merchant" do
    it "returns on merchant by their id" do
      id = create(:merchant).id

      get "/api/v1/merchants/#{id}"

      merchant = JSON.parse(response.body, symbolize_names: true)
      
      expect(response).to be_successful

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(Integer)

      expect(merchant).to have_key(:name)
      expect(merchant[:name]).to be_a(String)
    end
  end

  xdescribe " get all items for a given merchant ID" do
    it " " do

    end
  end
end
