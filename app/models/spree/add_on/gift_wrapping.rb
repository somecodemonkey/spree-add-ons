require_dependency 'spree/add_on'

module Spree
  class AddOn::GiftWrapping < Spree::AddOn
    # define the options for this add on via preferences
    preference :color, :string

    def self.display_name
      'Gift Wrapping'
    end

    def colors
      %W(red, blue, green)
    end

    private

    def valid_pref
      errors.add(:preferred_color, "invalid color") unless colors.include? preferred_color
    end

  end
end