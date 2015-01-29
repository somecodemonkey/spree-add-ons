require 'spec_helper'

describe Spree::LineItem do

  context "can have an addon" do

    let(:line_item) { create(:line_item) }
    let(:product) { create(:product, add_ons: [create(:add_on), create(:add_on, sku: 'DEF-123')]) }

    describe '.discounted_amount' do
      it "returns the amount minus any discounts and includes add_on fees" do
      end
    end

    context '.update_item_adjustments' do

      before do
        line_item.variant.product = product
      end

      it "returns the amount minus any discounts and includes add_on fees" do
        line_item.adjust_add_ons
      end
    end
  end

end
