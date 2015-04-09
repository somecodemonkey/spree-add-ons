class Spree::AddOn < Spree::Base
  acts_as_paranoid

  validates :name, presence: true
  validates :sku, presence: true, uniqueness: true
  validates :active, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :images, -> { order(:position) }, as: :viewable, dependent: :destroy, class_name: "Spree::Image"
  has_many :adjustments, as: :source
  has_many :line_items, through: :adjustments, as: :source
  has_and_belongs_to_many :products

  delegate :adjust, :compute_amount, to: :adjuster

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