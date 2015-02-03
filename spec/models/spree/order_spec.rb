require 'spec_helper'

describe Spree::Order, :type => :model do
  let(:user) { create(:user, :email => "spree@example.com", password: "spree123") }

  let(:bag) { create(:add_on) }
  let(:box) { create(:add_on, name: "Some dumb box", sku: "BAG-123", price: 20.00) }

  let(:product) { create(:product, add_ons: [bag, box]) }
  let(:product_two) { create(:product, add_ons: [bag]) }

  let(:line_item) { create(:line_item, variant: create(:variant, product: product)) }
  let(:line_item_two) { create(:line_item, variant: create(:variant, product: product_two)) }
  let!(:order) { create(:order, line_items: [line_item, line_item_two]) }

  before do
    allow(Spree::User).to receive_messages(:current => mock_model(Spree::User, :id => 123))
  end

  describe "add_on match" do
    before do
      order.line_items.first.add_ons = product.add_ons
    end

    it "matches to the correct line item with add ones" do
      options = {add_ons: product.add_ons.map(&:id)}
      expect(order.add_on_matcher(order.line_items.first, options)).to be true
    end

    it "returns false when no options" do
      expect(order.add_on_matcher(order.line_items.first, {})).to be false
    end

    it "returns false with empty add ons" do
      options = {add_ons: []}
      expect(order.add_on_matcher(order.line_items.first, options)).to be false
    end

    it "returns false with different add ons" do
      options = {add_ons: product_two.add_ons.map(&:id)}
      expect(order.add_on_matcher(order.line_items.first, options)).to be false
    end

    it "returns false with no product add ons" do
      options = {add_ons: product_two.add_ons.map(&:id)}
      expect(order.add_on_matcher(order.line_items.second, options)).to be false
    end
  end

end