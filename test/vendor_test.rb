require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/vendor'

class VendorTest < Minitest::Test
  def test_it_exists
    vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_has_readable_attributes
    vendor = Vendor.new("Rocky Mountain Fresh")
    expected = "Rocky Mountain Fresh"
    assert_equal expected, vendor.name
    assert_equal ({}), vendor.inventory
  end

  def test_it_can_check_stock
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal 0, vendor.check_stock(item1)
  end

  def test_it_can_stock_item
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock(item1, 30)
    expected = {
      item1 => 30
    }
    assert_equal expected, vendor.inventory

    vendor.stock(item1, 25)
    assert_equal 55, vendor.check_stock(item1)

    vendor.stock(item2, 12)
    expected = {
      item1 => 55,
      item2 => 12
    }
    assert_equal expected, vendor.inventory
  end
end
