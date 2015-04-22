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

    describe "self relation" do

      let (:add_on) { create(:add_on) }
      let! (:option) { create(:add_on, master: add_on, is_master: false) }

      it "should return self if master" do
        expect(add_on.master).to eq(add_on)
      end

      it "should return master" do
        expect(option.master).to eq(add_on)
      end

      it "should return masters option" do
        expect(add_on.options.first).to eq(option)
      end
    end
  end

  describe "option" do
    let(:add_on) { create(:add_on, option_types: [create(:option_type)]) }
    let(:product) { create(:product, add_ons: [add_on, create(:other_other_add_on)]) }
    let(:option_value) { create(:option_value) }
    let(:line_item) { create(:line_item, product: product) }

    it "creates a valid option" do
      add_on.attach_add_on(line_item)
      expect(line_item.add_ons.count).to eql 1
      expect(line_item.add_ons.first.master_id).to eql add_on.id
      expect(line_item.add_ons.first.is_master).to be false
    end

    it "creates a valid option with values" do
      add_on.attach_add_on(line_item, {"foo-size-1" => "Size-1"})
      expect(line_item.add_ons.count).to eql 1
      expect(line_item.add_ons.first.master_id).to eql add_on.id
      expect(line_item.add_ons.first.option_values.count).to eql 1
      expect(line_item.add_ons.first.option_values.first.name).to eql "Size-1"
    end
  end

  describe "callbacks" do
    let(:add_on) { create(:add_on) }

    it { expect(add_on).to callback(:touch_products).after(:save) }
  end

  describe "destroy" do
    let(:add_on) { create(:add_on) }
    let(:line_item) { create(:line_item) }
    let(:adjustment) { create(:adjustment, source: add_on, adjustable: line_item) }
  end

  describe "#images" do
    let(:add_on) { create(:add_on) }
    let(:image) { File.open(File.expand_path('../../../fixtures/nacho_taco.png', __FILE__)) }
    let(:params) { {:viewable_id => add_on.id, :viewable_type => 'Spree::AddOn', :attachment => image, :alt => "position 2", :position => 2} }

    it "only have an image" do
      img = Spree::AddOnImage.create!(params)
      expect(add_on.reload.images.first).to eql img
    end
  end

end
