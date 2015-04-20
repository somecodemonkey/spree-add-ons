FactoryGirl.define do

  factory :add_on, class: Spree::AddOn do
    name "bag"
    description "This is my bag. There are many like it, but this one is mine."
    sku "ABC-123"
    is_master true
    calculator
  end

  factory :other_add_on, class: Spree::OtherAddOn do
    name "Truffle Butter"
    description "Truffle...butter"
    sku "TB-OOPS"
    is_master true
    calculator
  end

  factory :other_other_add_on, class: Spree::OtherAddOn do
    name "gift wrapping"
    description "wrap that shiz"
    sku "WRAP-123"
    is_master true
    calculator
  end
end
