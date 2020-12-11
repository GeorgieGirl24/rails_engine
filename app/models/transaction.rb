class Transaction < ApplicationRecord
  belongs_to :invoice

  validates :credit_card_number, presence: true
  validates :credit_expiration_date, presence: true
  validates :result, presence: true
end
