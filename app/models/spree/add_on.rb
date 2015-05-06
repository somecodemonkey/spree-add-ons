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

    # Self polymorphic(?) relation yo
    # master is the AddOn itself
    # option is a child AddOn that contains the stored option_value/input(?) for the add on
    belongs_to :master, class_name: "#{self.to_s}"
    has_many :options, class_name: "#{self.to_s}", foreign_key: "master_id"

    delegate :adjust, :compute_amount, to: :adjuster

    accepts_nested_attributes_for :images, :allow_destroy => true

    cattr_accessor :permitted_values
    self.permitted_values = Set.new

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

    def attach_add_on(line_item, values = {})
      new_add_on = create_option(values)
      adjustment = adjuster.adjust(line_item)

      if adjustment.present?
        adjustment.source = new_add_on
        adjustment.save!
      end
    end

    def values
      preferences
    end

    def values=(props)
      props.keys.each do |key|
        if has_preference? key.to_sym
          set_preference(key.to_sym, props[key])
        end
      end
    end

    def as_json(opts = {})
      super(opts.merge(
                only: Spree::Api::ApiHelpers.add_on_attributes,
                methods: [:values],
                include: [:images]
            )
      )
    end

    def self.display_name
      'Basic'
    end

    private

    def create_option(values)
      master.options.create!({
                                 type: type,
                                 master: master,
                                 name: master.name,
                                 values: values
                             })
    end

    def touch_products
      products.each(&:touch)
    end

  end
end
