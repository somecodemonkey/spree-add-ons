require 'spec_helper'

describe Spree::Product do

  describe "Model" do

    let(:add_on_one) { create(:other_add_on) }
    let(:add_on_two) { create(:other_other_add_on) }
    let(:product) { create(:product) }

    it "enforces unique add ons" do
      add_on = create(:add_on)
      FactoryGirl.build(:product, add_ons: [add_on, add_on]).should_not be_valid
    end

    it "enforces unique add ons" do
      expect { product.add_ons = [add_on_one, add_on_one]}.to raise_error
    end

    it "allows distinct add ons" do
      FactoryGirl.build(:product, add_ons: [add_on_one, add_on_two]).should be_valid
    end
  end
end
