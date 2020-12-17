class Invoice < ApplicationRecord
  validates :status, presence: true
  belongs_to :customer
  belongs_to :merchant

  has_many :invoice_items
  has_many :transactions, dependent: :destroy
  has_many :items, through: :invoice_items

  scope :successful, -> { where(status: 'shipped') }

  def self.most_expensive(quantity)
    joins(:invoice_items, :transactions)
      .merge(Transaction.successful)
      .merge(Invoice.successful)
      .select('invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
      .group(:id)
      .order("revenue DESC").limit(quantity)
  end
end
