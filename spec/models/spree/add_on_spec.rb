require 'spec_helper'

class Spree::Bag < Spree::AddOn
end

describe Spree::AddOn do

  describe "Validations" do
    it "has a valid factory" do
      FactoryGirl.build(:add_on).should be_valid
    end

    it "requires name" do
      FactoryGirl.build(:add_on, name: nil).should_not be_valid
    end

    it "requires active" do
      FactoryGirl.build(:add_on, active: nil).should_not be_valid
    end


    it "requires sku" do
      FactoryGirl.build(:add_on, sku: nil).should_not be_valid
    end

    describe "STI" do
      # describe "#create" do
      #   it "should work" do
      #     expect{ Spree::Bag.create(name: "This is a bag yo!", price: 3.50, sku: "YO-BAG") }.to_not raise_error
      #   end
      # end

      let (:add_on) { create(:add_on) }
      let (:option) { create(:add_on, master: add_on, is_master: false)}

      it "should return self if master" do
        puts add_on.master.inspect
        expect(add_on.master).to eq(add_on)
      end

      it "should return master" do
        expect(option.master).to eq(add_on)
      end
    end
  end

  describe "callbacks" do
    let(:add_on) { create(:add_on) }

    it { expect(add_on).to callback(:touch_products).after(:save) }
  end

  describe "#images" do
    let(:add_on) { create(:add_on) }
    let(:image) { File.open(File.expand_path('../../../fixtures/nacho_taco.png', __FILE__)) }
    let(:params) { {:viewable_id => add_on.id, :viewable_type => 'Spree::AddOn', :attachment => image, :alt => "position 2", :position => 2} }

    it "only have an image" do
      img = Spree::Image.create(params)
      expect(add_on.image).to eql img
    end
  end

end
