class Market

  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def total_inventory
    inventory = {}
    @vendors.each do |vendor|
      vendor.inventory.each do |stock, amount|
        if inventory[stock].nil?
          inventory[stock] = {
            quantity: 0,
            vendors: []
          }
        end
        inventory[stock][:quantity] += amount
        inventory[stock][:vendors] << vendor
      end
    end
    inventory
  end

  def sorted_item_list
    result = @vendors.flat_map do |vendor|
      vendor.inventory.keys.flat_map do |item|
        item.name
      end
    end.uniq.sort
  end

  def overstocked_items
    result = []
    total_inventory.each do |item, value|
      quantity_over_vendor_count = value[:quantity] / (value[:vendors].count)
      if value[:vendors].count > 1 && (quantity_over_vendor_count > 49)
        result << item
      end
    end
    result
  end
end
