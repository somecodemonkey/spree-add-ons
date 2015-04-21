class Spree::OtherAddOn < Spree::AddOn

  # Easiest way to mimic option types in spree
  OPTIONS = {
      color: ["red", "blue", "green"]
  }

  def self.display_name
    'Other Add On'
  end
end