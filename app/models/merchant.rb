class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, dependent: :destroy

  validates :name, presence: true

  def self.search_single(attribute, search)
    if attribute == 'created_at' || attribute == 'updated_at'
      search_date(attribute, search).first
    else
      search_string(attribute, search).first
    end
  end

  def self.search_string(attribute, search)
      where("#{attribute} ILIKE ?",  "%#{search}%")
  end

  def self.search_date(attribute, search)
    where("DATE(#{attribute}) = ?", "%#{search}%")
  end

  def self.search_multiple(attribute, search)
    if attribute == 'created_at' || attribute == 'updated_at'
      search_date(attribute, search)
    else
      search_string(attribute, search)
    end
  end
end
