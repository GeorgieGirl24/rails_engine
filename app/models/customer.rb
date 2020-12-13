class Customer < ApplicationRecord
  has_many :invoices, dependent: :destory

  validates :first_name, presence: true
  validates :last_name, presence: true
end
