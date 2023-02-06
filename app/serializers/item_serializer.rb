class ItemSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :unit_price

  # def self.format_items(item)
    # {
    #   data: items.map do |item|
    #     {
    #       id: item.id
    #       attributes: {
    #         name: item.name
    #         description: item.description
    #         unit_price: item.unit_price
    #       }
    #     }
    #   end
    # }
  # end
end