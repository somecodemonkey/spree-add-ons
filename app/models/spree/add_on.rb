=begin
Current Plan:
AddOn options will inherit this class and structured via STI
Eg. Spree::Bag < Spree::AddOn

Where variations between bags will be defined via SKU
Eg. Spree::Bag = <pref: {color: black}, SKU:'ABC-123'>
=end
class Spree::AddOn < Spree::Base
  acts_as_paranoid

  validates :name, presence: true
  validates :sku, presence: true, uniqueness: true
  validates :active, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :images, -> { order(:position) }, as: :viewable, dependent: :destroy, class_name: "Spree::Image"
  has_many :adjustments, as: :source
  has_and_belongs_to_many :products

  delegate :adjust, :compute_amount, to: :adjuster

  def adjuster
    @adjuster ||= Spree::AddOnAdjuster.new(self)
  end

end