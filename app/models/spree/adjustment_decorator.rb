module Spree
  Adjustment.class_eval do
    SUBCLASSES = Spree::AddOn.subclasses.map{|c| c.name}

    scope :add_ons, -> { where(source_type: SUBCLASSES.push("Spree::AddOn")) }

    SUBCLASSES.each do |subclass|
      name = subclass.split("::")[1].split(/(?=[A-Z])/).join("_") + "s"
      scope name.to_sym, -> { where(source_type: subclass) }
    end
  end
end