require 'spec_helper'

describe Spree::Product do

  describe "Model" do

    it "requires add_on options" do
    end

  end

  describe "add_on options" do
    # Currently using Spree-item-designs as a model we would something like this
    # let(:product) { create(:product, add_on_options: ["gift_package", "wrapping"]) }
    #
    # Alternatively we could set up a direct relation, seems a bit 'safer' than simply comparing strings like we've been doing
    # let(:product) { create(:product, add_on_options: [create(:gift_package), create(:wrapping)]) }

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
