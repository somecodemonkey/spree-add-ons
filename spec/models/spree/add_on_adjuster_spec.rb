require 'spec_helper'

describe Spree::AddOnAdjuster do

  let(:add_on) { create(:add_on) }
  let(:adjuster) { Spree::AddOnAdjuster.new(add_on) }

  context "add on totals" do

    let(:product) { create(:product, add_ons: [add_on]) }
    let!(:line_item) { create(:line_item, variant: create(:variant, product: product)) }

    it "should create the adjustments" do
      allow(adjuster).to receive(:is_new?).and_return(true)
      adjuster.adjust(line_item)
      expect(add_on.adjustments.count).to eq 1
    end

    it "should compute correclty" do
      expect(adjuster.compute_amount(line_item)).to eq 10
    end
  end

end