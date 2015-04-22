require 'spec_helper'

module Spree
  PermittedAttributes.module_eval do
    mattr_writer :line_item_attributes
  end

  unless PermittedAttributes.line_item_attributes.include? :add_ons
    PermittedAttributes.line_item_attributes += [:add_ons]
  end


  describe Api::LineItemsController, :type => :controller do
    render_views

    let (:user) { create(:user, spree_api_key: rand) }
    let (:add_on_one) { create(:add_on) }
    let (:add_on_two) { create(:other_add_on) }
    let (:product) { create(:product, add_ons: [add_on_one]) }
    let (:line_item) { create(:line_item, variant: create(:variant, product: product)) }
    let! (:order) { create(:order, line_items: [line_item], user: user) }

    let(:attributes) { [:id, :quantity, :price, :variant, :total, :display_amount, :single_display_amount, :add_ons] }
    let(:resource_scoping) { {:order_id => order.to_param} }

    before do
      stub_authentication!
      @current_api_user = user
    end

    describe "#create" do

      it "with an valid add_on" do
        api_post :create,
                 line_item: {
                     variant_id: product.master.id,
                     quantity: 1,
                     options: {
                         add_ons: [
                             {
                                 master_id: add_on_one.id
                             }
                         ]
                     }
                 },
                 order_token: order.guest_token
        order.line_items.reload
        expect(order.line_items.count).to eql 2
        expect(order.line_items.second.add_ons.first.master.id).to eql add_on_one.id
        expect(response.status).to eq(201)
      end

      it "with an invalid add_on" do
        api_post :create,
                 line_item: {
                     variant_id: product.master.id,
                     quantity: 1,
                     options: {
                         add_ons: [
                             {
                                 master_id: add_on_two.id
                             }
                         ]
                     }
                 },
                 order_token: order.guest_token
        order.line_items.reload
        expect(response.status).to eq(422)
      end
    end

    describe "#update" do
      it "with an valid add_on" do
        api_put :update,
                :id => line_item.id,
                :line_item => {
                    :quantity => 1,
                    :options => {
                        add_ons: [
                            {
                                master_id: add_on_one.id
                            }
                        ]
                    }
                }
        expect(response.status).to eq(200)
        expect(json_response).to have_attributes(attributes)
        expect(json_response["add_ons"][0]["master_id"]).to eql add_on_one.id
      end

      it "with an invalid add_on" do
        api_put :update,
                :id => line_item.id,
                :line_item => {
                    :quantity => 1,
                    :options => {
                        add_ons: [
                            {
                                master_id: add_on_two.id
                            }
                        ]
                    }
                }
        expect(response.status).to eq(422)
        expect(json_response["error"]).to eq "Invalid resource. Please fix errors and try again."
      end
    end

    describe "#remove_add_ons" do

      before(:each) do
        product.add_ons = [add_on_one, add_on_two]
        line_item.add_ons = [add_on_one, add_on_two].map { |add_on| {master_id: add_on.id} }
        line_item.save!
      end

      it "removes add_ons" do
        api_put :update,
                :id => line_item.id,
                :line_item => {
                    :quantity => 1,
                    :options => {
                        add_ons: []
                    }
                }
        expect(line_item.reload.add_ons.empty?).to be true
        expect(response.status).to eq(200)
      end
    end

  end
end