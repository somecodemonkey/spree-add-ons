=begin
An example subclass of spree addon, akin to custom calculators in spree
Leaning towards STI for individual addons.
=end
describe Spree::GiftBag do

  # Daddeo
  # Yes I think STI is the correct way, all we need to do is give it a preferences column
  # and then we don't have to worry about bloated tables for different types
  # Honestly though I would put almost not focus on the subclasses at this point, it might "twist" the thinking.
  # Think of creating the base class that will provide a solid API, after that we just need the subclasses
  # to implement it.


  # has options eg. velvet/plastic/paper
  # images per option

end