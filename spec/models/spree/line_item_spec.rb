require 'spec_helper'

describe Spree::LineItem do

  let(:product) { create(:product, add_ons: [create(:add_on), create(:add_on, sku: 'DEF-123')]) }
  let(:line_item) { create(:line_item, variant: create(:variant, product: product)) }


  context "no current addons" do
    it "should create the adjustments" do
      line_item.add_ons = product.add_ons
      expect(line_item.adjustments.count).to eq 2
      expect(line_item.adjustments.map(&:id) - product.add_ons.map(&:id)).to be_empty
    end

    it "calculates the discounted amount" do
      line_item.add_ons = product.add_ons
      expect(line_item.discounted_amount).to eql 30.00
    end

    it "correctly updates the price" do
      line_item.quantity = 3
      line_item.add_ons = product.add_ons
      expect(line_item.discounted_amount).to eql 90.00
    end
  end

  context "with current addons" do
    it "does not duplicate adjusmtents" do
      line_item.add_ons = [product.add_ons, product.add_ons]
      expect(line_item.adjustments.count).to eq 2
      expect(line_item.add_ons.map(&:id) - product.add_ons.map(&:id)).to be_empty
    end
  end

end
