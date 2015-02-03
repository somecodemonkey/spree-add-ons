Spree::LineItem.class_eval do

  after_save :update_add_on_adjustments
  after_save :persist_add_on_total

  # potential optimization here
  def add_on_total
    adjustments.add_ons.reload.map do |adjustment|
      adjustment.update!(self)
    end.compact.sum
  end

  def add_ons
    adjustments.add_ons.map(&:source)
  end

  def add_ons=(*new_add_ons)
    new_add_ons.flatten!.each { |add_on| add_on.adjust(self) }
  end

  private

  def update_add_on_adjustments
    if quantity_changed?
      add_ons.each { |add_on| add_on.adjust(self) }
    end
  end

  def persist_add_on_total
    if quantity_changed?
      update_columns(
          :add_on_total => add_on_total
      )
    end
  end

end