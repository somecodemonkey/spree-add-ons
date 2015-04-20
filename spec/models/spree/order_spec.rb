require 'spec_helper'

describe Spree::Order, :type => :model do
  let(:user) { create(:user, :email => "spree@example.com", password: "spree123") }

  let(:bag) { create(:other_add_on) }
  let(:box) { create(:other_other_add_on) }

  let!(:product) { create(:product, add_ons: [bag, box]) }
  let!(:product_two) { create(:product, add_ons: [bag]) }

  let!(:line_item) { create(:line_item, variant: create(:variant, product: product)) }
  let!(:order) { create(:order, line_items: [line_item]) }

  before do
    allow(Spree::User).to receive_messages(:current => mock_model(Spree::User, :id => 123))
  end

  describe "add_on match" do
    before do
      line_item.add_ons = product.add_ons
      order.line_items.first.reload
    end

    it "matches to the correct line item with add ones" do
      options = {add_on_ids: line_item.add_ons.map(&:id)}
      expect(order.add_on_matcher(order.line_items.first, options)).to be true
    end

    it "returns false when no options" do
      expect(order.add_on_matcher(order.line_items.first, {})).to be false
    end

    it "returns false with empty add ons" do
      options = {add_on_ids: []}
      expect(order.add_on_matcher(order.line_items.first, options)).to be false
    end

    it "returns false with different add ons" do
      options = {add_on_ids: product_two.add_ons.map(&:id)}
      expect(order.add_on_matcher(order.line_items.first, options)).to be false
    end

    it "returns false with no product add ons" do
      options = {add_on_ids: product_two.add_ons.map(&:id)}
      expect(order.add_on_matcher(order.line_items.first, options)).to be false
    end
  end

  describe "when add on is deleted" do
    before do
      order.line_items.first.add_ons = product.add_ons
      order.line_items.first.reload
    end

    it "should mark the order invalid" do
      bag.destroy
      expect(order.reload.invalid?).to be true
    end
  end

end