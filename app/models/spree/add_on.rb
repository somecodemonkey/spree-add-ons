class Spree::AddOn < Spree::Base
  acts_as_paranoid

  has_and_belongs_to_many :products
  has_many :adjustments, as: :source

  validates :name, presence: true
  validates :sku, presence: true
  validates :active, presence: true
  validates :price, presence: true, numericality: true

end