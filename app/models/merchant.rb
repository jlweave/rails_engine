class Merchant < ApplicationRecord
  has_many :items

  def self.search_one_name(name)
    self.order(:name).find_by("name ILIKE ?", "%#{name}%")
  end

  def self.all_names(name)
    # require 'pry'; binding.pry
    self.order(:name).where("name ILIKE ?", "%#{name}%")
  end
end