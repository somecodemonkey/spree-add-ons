require 'spec_helper'

describe Spree::AddOn do

  describe "Model" do
    it "has a valid factory" do
      FactoryGirl.build(:add_on).should be_valid
    end

    it "requires name" do
      FactoryGirl.build(:add_on, name: nil).should_not be_valid
    end

    it "requires active" do
      FactoryGirl.build(:add_on, active: nil).should_not be_valid
    end

    it "requires price" do
      FactoryGirl.build(:add_on, price: nil).should_not be_valid
    end

    it "requires sku" do
      FactoryGirl.build(:add_on, sku: nil).should_not be_valid
    end
  end

  describe "adjustments" do

    context "create" do
      it "creates adjustments for valid addons" do
      end

      it "will not duplicate adjustments" do
      end

      it "wont create adjustment for inactive addons" do
      end
    end

    context "remove" do
      before do
        # create and add on the adjustments
      end

      it "removes the adjustments" do
        # remove the add_on
      end

    end

  end

end
