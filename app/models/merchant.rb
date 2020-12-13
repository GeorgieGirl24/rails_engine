class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy

  validates :name, presence: true

  def self.search_single(merchant_params)
    where("#{merchant_params.to_h.keys.first} ILIKE ?",  "%#{merchant_params.to_h.values.first}%")
  end
end
