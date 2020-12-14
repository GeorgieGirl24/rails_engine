class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items


  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def self.search_single(item_params)
    search = item_params.values.first
    attribute = item_params.keys.first
    where("#{attribute} ILIKE ?",  "%#{search}%")
  end

  def self.search_date(item_params)
    search = item_params.values.first
    attribute = item_params.keys.first
    where("DATE(#{attribute}) = ?", "%#{search}%")
  end

  def self.unit_price_search(item_params)
    search = item_params.values.first
    attribute = item_params.keys.first
    where("to_char(#{attribute}, '99999999.99') ILIKE ?", "%#{search}%")
  end
end
