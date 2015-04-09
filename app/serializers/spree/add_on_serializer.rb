module Spree
  module Core
    class AddOnSerializer < ActiveModel::Serializer

      self.root = false

      attributes :id, :name, :type, :sku, :active, :price, :description

    end

  end
end