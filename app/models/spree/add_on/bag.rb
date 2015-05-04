require_dependency 'spree/add_on'
module Spree
  class AddOn::Bag < Spree::AddOn
    preference :monogram, :string

    def self.display_name
      'Bag'
    end

  end
end