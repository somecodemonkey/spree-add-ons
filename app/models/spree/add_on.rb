module Spree
  class AddOn < Spree::Base
    acts_as_paranoid

    include Spree::CalculatedAdjustments

    validates :calculator, presence: true, if: :is_master?
    validates :name, presence: true, if: :is_master?
    validates :sku, presence: true, uniqueness: true, if: :is_master?
    validates :active, presence: true, if: :is_master?

    after_save :touch_products

    scope :active, -> { where(active: true) }
    scope :master, -> { where(is_master: true, master_id: nil) }

    # Spree relations
    has_one :line_item, through: :adjustment, as: :source
    has_one :adjustment, as: :source, dependent: :destroy
    has_many :images, as: :viewable, dependent: :destroy, class_name: "Spree::AddOnImage"
    has_and_belongs_to_many :products
    has_and_belongs_to_many :option_types, join_table: :spree_option_types_add_ons
    has_and_belongs_to_many :option_values, join_table: :spree_option_values_add_ons

    # Self relation
    # master is the AddOn itself
    # option is a child AddOn that contains the stored option_value/input(?) for the add on
    belongs_to :master, class_name: "Spree::AddOn"
    has_many :options, class_name: "Spree::AddOn", foreign_key: "master_id"

    delegate :adjust, :compute_amount, to: :adjuster

    accepts_nested_attributes_for :images

    def adjuster
      @adjuster ||= Spree::AddOnAdjuster.new(self)
    end

    def master
      if is_master?
        self
      else
        # unscope for relations
        self.class.unscoped { super }
      end
    end

    def attach_add_on(line_item, props = {})
      new_add_on = create_option(props)
      adjustment = adjuster.adjust(line_item)

      if adjustment.present?
        adjustment.source = new_add_on
        adjustment.save!
      end
    end

    def options=(options = {})
      self.option_values.destroy_all
      options.each do |name, value|
        set_option_value(name, value)
      end
    end

    def get_option_image(option)
      images.select { |img| img.preferred_option_value_id == option.id }.first
    end

    def self.display_name
      'Basic'
    end

    def self.types
      Spree::AddOn.subclasses.push(Spree::AddOn)
    end

    private

    def create_option(options)
      master.options.create!({
                                 master: master,
                                 name: master.name,
                                 options: options
                             })
    end

    def set_option_value(opt_name, opt_value)
      return if self.is_master

      option_type = Spree::OptionType.where(name: opt_name).first_or_initialize do |o|
        o.presentation = opt_name
        o.save!
      end

      option_value = Spree::OptionValue.where(option_type_id: option_type.id, name: opt_value).first_or_initialize do |o|
        o.presentation = opt_value
        o.save!
      end

      self.option_values << option_value
      self.save
    end

    def touch_products
      products.each(&:touch)
    end
  end
end
# require_dependency 'spree/add_on'
