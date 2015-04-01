FactoryGirl.define do

  class Spree::OtherAddOn < Spree::AddOn
  end

  class Spree::OtherOtherAddOn < Spree::AddOn
  end

  factory :add_on, class: Spree::AddOn do
    name "bag"
    description "This is my bag. There are many like it, but this one is mine."
    sku "ABC-123"
    price 10.00
  end

  factory :other_add_on, class: Spree::OtherAddOn do
    name "Truffle Butter"
    description "Truffle...butter"
    sku "TB-OOPS"
    price 3.50
  end

  factory :other_other_add_on, class: Spree::OtherAddOn do
    name "gift wrapping"
    description "wrap that shiz"
    sku "WRAP-123"
    price 5.00
  end
end
