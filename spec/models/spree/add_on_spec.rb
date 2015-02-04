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

  describe "#images" do
    let(:add_on) { create(:add_on) }
    let(:image) { File.open(File.expand_path('../../../fixtures/nacho_taco.png', __FILE__)) }
    let(:params) { {:viewable_id => add_on.id, :viewable_type => 'Spree::AddOn', :attachment => image, :alt => "position 2", :position => 2} }

    before do
      Spree::Image.create(params)
      Spree::Image.create(params.merge({:alt => "position 1", :position => 1}))
    end

    it "only looks for variant images" do
      expect(add_on.images.size).to eq(2)
    end

    it "should be sorted by position" do
      expect(add_on.images.pluck(:alt)).to eq(["position 1", "position 2"])
    end
  end

end
