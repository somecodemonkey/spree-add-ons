class Spree::AddOn < Spree::Base
  acts_as_paranoid

  has_and_belongs_to_many :products
  has_many :adjustments, as: :source
  has_many :images, -> { order(:position) }, as: :viewable, dependent: :destroy, class_name: "Spree::Image"

  validates :name, presence: true
  validates :sku, presence: true
  validates :active, presence: true
  validates :price, presence: true, numericality: true

end