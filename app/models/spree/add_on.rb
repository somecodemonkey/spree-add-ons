class Spree::AddOn < Spree::Base
  acts_as_paranoid
  include Spree::CalculatedAdjustments

  validates :calculator, presence: true, if: :is_master?
  validates :name, presence: true, if: :is_master?
  validates :sku, presence: true, uniqueness: true, if: :is_master?
  validates :active, presence: true, if: :is_master?

  after_save :touch_products

  scope :active, -> { where(active: true) }
  scope :master, -> { where(is_master: true, master_id: nil)}

  # has_one :line_item, through: :adjustment, as: :source
  has_one :adjustment, as: :source
  has_one :image, as: :viewable, dependent: :destroy, class_name: "Spree::Image"
  belongs_to :master, class_name: "Spree::AddOn"
  has_many :options, class_name: "Spree::AddOn", foreign_key: "master_id"
  has_and_belongs_to_many :products

  delegate :adjust, :compute_amount, to: :adjuster

  accepts_nested_attributes_for :image

  def adjuster
    @adjuster ||= Spree::AddOnAdjuster.new(self)
  end

  def master
    if is_master?
      self
    else
      Spree::AddOn.unscoped { super }
    end
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