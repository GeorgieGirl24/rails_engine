class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy

  validates :name, presence: true

  def self.search_single(attribute, search)
    if %w[created_at updated_at].include?(attribute)
      search_date(attribute, search).first
    elsif attribute == 'name'
      search_string(attribute, search).first
    end
  end

  def self.search_string(attribute, search)
    where("#{attribute} ILIKE ?", "%#{search}%")
  end

  def self.search_date(attribute, search)
    where("DATE(#{attribute}) = ?", "%#{search}%")
  end

  def self.search_multiple(attribute, search)
    if %w[created_at updated_at created_at updated_at created_at updated_at].include?(attribute)
      search_date(attribute, search)
    else
      search_string(attribute, search)
    end
  end

  def self.most_revenue(quantity)
    joins(invoices: [:transactions, :invoice_items])
      .where( { transactions: { result: 'success' } })
      .select('merchants.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue')
      .group(:id)
      .order('revenue DESC')
      .limit(quantity)
  end

  def self.most_items(quantity)
    joins(invoices: [:transactions, :invoice_items])
      .select('merchants.*, SUM(invoice_items.quantity) AS quantity_items')
      .group(:id)
      .order('quantity_items DESC')
      .limit(quantity)
  end

  def self.single_revenue(id)
    total_revenue = Invoice.joins(:transactions, :invoice_items)
      .merge(Transaction.successful)
      .merge(Invoice.successful)
      .where(merchant_id: id)
      .sum('unit_price * quantity')
    Revenue.new(total_revenue)
  end
end
