class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def self.search_single(attribute, search)
    if %w[created_at updated_at].include?(attribute)
      search_date(attribute, search).first
    elsif attribute == 'unit_price'
      unit_price_search(attribute, search).first
    else
      search_string(attribute, search).first
    end
  end

  def self.search_string(attribute, search)
    where("#{attribute} ILIKE ?", "%#{search}%")
  end

  def self.search_date(attribute, search)
    where("DATE(#{attribute}) = ?", "%#{search}%")
  end

  def self.unit_price_search(attribute, search)
    where("to_char(#{attribute}, '99999999.99') ILIKE ?", "%#{search}%")
  end

  def self.search_multiple(attribute, search)
    if %w[created_at updated_at created_at updated_at created_at updated_at].include?(attribute)
      search_date(attribute, search)
    elsif attribute == 'unit_price'
      unit_price_search(attribute, search)
    else
      search_string(attribute, search)
    end
  end
end
