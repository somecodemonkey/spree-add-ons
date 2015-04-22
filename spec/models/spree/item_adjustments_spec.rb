require 'spec_helper'

module Spree
  describe ItemAdjustments, :type => :model do
    context "with add on" do
      let (:add_on) { create(:other_add_on) }
      let (:product) { create(:product, add_ons: [add_on]) }
      let (:line_item) { create(:line_item, variant: create(:variant, product: product)) }
      let (:subject) { ItemAdjustments.new(line_item) }

      before do
        line_item.add_ons = [add_on].map { |add_on| {master_id: add_on.id} }
        line_item.save!
      end

      it "should update the totals" do
        subject.update
        expect(line_item.add_on_total).to eql 10
        expect(line_item.adjustment_total).to eql 10
      end
    end
  end
end