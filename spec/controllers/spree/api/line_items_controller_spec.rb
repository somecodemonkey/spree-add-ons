require 'spec_helper'

module Spree
  describe Api::LineItemsController, :type => :controller do

=begin
    Thoughts:
    Hooking this into options via line_item: {options: {add_on_id: #}} and defining matcher may produce weird
    behavior with item designs since matchers are automatically. Alternatively we could not define a matcher but we
    would not be able to find line_item by add on, or we could create a custom api to add on a line item.
=end

    it "can attach an addon to a line item" do

    end

    it "can create a line_item with an add on" do

    end

  end
end