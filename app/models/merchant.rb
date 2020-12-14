class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy

  validates :name, presence: true

  def self.search_single(merchant_params)
    search = merchant_params.values.first
    attribute = merchant_params.keys.first
    where("#{attribute} ILIKE ?",  "%#{search}%")
  end

  def self.search_date(merchant_params)
    search = merchant_params.values.first
    attribute = merchant_params.keys.first
    where("DATE(#{attribute}) = ?", "%#{search}%")
    # wrap it in date look it up like doesn't like dates
    # so use something else like '='
    # where("to_char(#{attribute},'yyyy-mon-dd-HH-MI-SS') ILIKE ?", "%#{search}%")
    # binding.pry
  end
end
