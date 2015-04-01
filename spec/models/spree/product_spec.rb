require 'spec_helper'

describe Spree::Product do

  describe "Model" do
    ## validate sti as well?
    it "enforces unique options" do
      add_on = create(:add_on)
      FactoryGirl.build(:product, add_ons: [add_on, add_on]).should_not be_valid
    end
  end

  describe "add_on options" do
    # let(:product) { create(:product, add_ons: [create(:add_on), create(:add_on, sku: 'DEF-123')]) }

    let(:add_on_one) { create(:other_add_on) }
    let(:add_on_two) { create(:other_other_add_on) }

    describe "existing options" do
      it "can have gift package" do
      end

      it "can have gift wrapping" do
      end

      it "cannot have xyz" do
      end
    end

    describe "updating options" do
      context "adding options" do
        it "should not invalidate the product" do
        end

        it "should not allow duplicate options" do
        end
      end

      context "removing options" do
        it "should correctly invalidate products" do
        end

        it "should create errors messages" do
        end
      end
    end


  end

end
