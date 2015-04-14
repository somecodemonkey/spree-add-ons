class Spree::AddOn < Spree::Base
  acts_as_paranoid
  include Spree::CalculatedAdjustments

  # this will be *more* useful in spree 3
  include Spree::AdjustmentSource

  validates :name, presence: true
  validates :sku, presence: true, uniqueness: true
  validates :active, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_one :image, as: :viewable, dependent: :destroy, class_name: "Spree::Image"
  has_many :adjustments, as: :source
  has_many :line_items, through: :adjustments, as: :source
  has_and_belongs_to_many :products

  delegate :adjust, :compute_amount, to: :adjuster

  accepts_nested_attributes_for :image

  after_save :touch_products

  scope :active, -> { where(active: true) }

  def adjuster
    @adjuster ||= Spree::AddOnAdjuster.new(self)
  end

  # override this
  def self.display_name
    'Add On'
  end

  private

  def touch_products
    products.each(&:touch)
  end
end