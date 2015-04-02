require 'spec_helper'

describe Spree::LineItem do

  let(:product) { create(:product, add_ons: [create(:add_on), create(:add_on, sku: 'DEF-123')]) }
  let(:line_item) { create(:line_item, variant: create(:variant, product: product)) }
  let(:other_add_on) { create(:other_add_on) }

  context "callbacks" do
    it { expect(line_item).to callback(:update_add_on_adjustments).after(:save) }
    it { expect(line_item).to callback(:persist_add_on_total).after(:save) }
  end

  it "only allows valid add ons" do
    line_item.add_ons = [other_add_on]
    expect{ line_item.save! }.to raise_error
  end

  context "no current addons" do
    it "should 'create' the add ons" do
      expect(product.add_ons[0]).to receive(:adjust).with(line_item)
      expect(product.add_ons[1]).to receive(:adjust).with(line_item)
      line_item.add_ons = product.add_ons
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

    it "retrieves the add ons" do
      line_item.add_ons = product.add_ons
      expect(line_item.add_ons.map(&:id) - product.add_ons.map(&:id)).to be_empty
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
