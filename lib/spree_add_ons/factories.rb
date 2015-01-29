FactoryGirl.define do

  factory :add_on, class: Spree::AddOn do
    name "bag"
    description "This is my bag. There are many like it, but this one is mine."
    sku "abc123"
    price 10.00
  end
end
