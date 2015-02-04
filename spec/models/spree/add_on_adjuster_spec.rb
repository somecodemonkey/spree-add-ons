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

    it "will not duplicate adjustments" do
      allow(adjuster).to receive(:is_new?).and_return(true)
      adjuster.adjust(line_item)
      adjuster.adjust(line_item)
      expect(add_on.adjustments.count).to eq 1
    end

    it "wont create adjustment for inactive addons" do
      allow(adjuster).to receive(:active).and_return(false)
      allow(adjuster).to receive(:is_new?)
      adjuster.adjust(line_item)
      expect(add_on.adjustments.count).to eq 0
    end

    it "wont create adjustment for 0 price addons" do
      allow(adjuster).to receive(:compute_amount).and_return(0)
      allow(adjuster).to receive(:is_new?)
      adjuster.adjust(line_item)
      expect(add_on.adjustments.count).to eq 0
    end

    it "should compute correclty" do
      expect(adjuster.compute_amount(line_item)).to eq 10
    end
  end

end