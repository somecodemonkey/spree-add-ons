require 'spec_helper'

describe Spree::AddOnAdjuster do

  let(:master_add_on) { create(:add_on) }
  let(:adjuster) { Spree::AddOnAdjuster.new(master_add_on) }

  context "add on totals" do

    let(:product) { create(:product, add_ons: [master_add_on]) }
    let!(:line_item) { create(:line_item, variant: create(:variant, product: product)) }

    it "should create the adjustments" do
      allow(adjuster).to receive(:is_new?).and_return(true)
      adjuster.adjust(line_item)
      # source type not set in adjuster
      expect(line_item.adjustments.count).to eql 1
      expect(master_add_on.adjustment).to be nil
    end

    it "will not duplicate adjustments" do
      allow(adjuster).to receive(:is_new?).and_return(true)
      adj = adjuster.adjust(line_item)
      allow(adjuster).to receive(:adjustment_for).and_return(adj)
      adjuster.adjust(line_item)
      expect(line_item.adjustments.count).to eql 1
      expect(master_add_on.adjustment).to be nil
    end

    it "wont create adjustment for inactive addons" do
      allow(master_add_on).to receive(:active).and_return(false)
      allow(adjuster).to receive(:is_new?)
      adjuster.adjust(line_item)
      expect(line_item.adjustments.add_ons.count).to eql 0
      expect(master_add_on.adjustment).to be nil
    end

    it "wont create adjustment for 0 price addons" do
      allow(adjuster).to receive(:compute_amount).and_return(0)
      allow(adjuster).to receive(:is_new?)
      adjuster.adjust(line_item)
      expect(line_item.adjustments.add_ons.count).to eql 0
      expect(master_add_on.adjustment).to be nil
    end

    it "should compute correclty" do
      expect(adjuster.compute_amount(line_item)).to eq 10
    end
  end

end