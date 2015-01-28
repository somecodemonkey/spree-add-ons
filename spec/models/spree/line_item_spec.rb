require 'spec_helper'

describe Spree::LineItem do

  context "can have an addon" do

    describe '.discounted_amount' do
      it "returns the amount minus any discounts and includes add_on fees" do
      end
    end

    context '.update_item_adjustments' do

      before do
        #line_item.adjustments.add_ons << some_addon's adjustment
      end

      it "returns the amount minus any discounts and includes add_on fees" do
      end
    end
  end

end
