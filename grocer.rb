require 'pry'

def consolidate_cart(cart)
  consolidated_cart = {}
  item_list = []

  cart.each do |item|
    #binding.pry
    item_name = item.keys[0]
    item_info = item.values[0]
    #binding.pry
    if item_list.include?(item_name) == false
    #binding.pry
      item_list.push(item_name)
      item_info[:count] = cart.count(item)
      consolidated_cart[item_name] = item_info
    end

  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  #empty hash to store final cart
  discounted_cart = {}

  #create hash of coupon names with key as coupons index
  coupon_list = {}
  coupons.each_with_index do |coupon, index|
    coupon_list[coupon[:item]] = index
  end

  #loop through cart
  cart.each do |item, details|
    price = details[:price]
    clearance = details[:clearance]
    count = details[:count]

    #check if there is a coupon for item in cart
    #if coupon, apply coupon and return discounted items
    #and any remaining items
    if coupon_list.keys.include?(item)

    #use the coupon list to find array index in coupons
    coupon_info = coupons[coupon_list[item]]

    #create variables to use in updated cart
    discount_item = coupon_info[:item]
    discount_price = coupon_info[:cost]
    discount_count = coupon_info[:num]

    #calculate how many times the coupon applies and
    #how many items remainin
    coupon_bundles = count / discount_count
    remaining_items = count % discount_count

    #I've commented out this if statement - it removes items
    #completely if the coupon applies to all the items. This
    #seems more effecient but didn't exactly solve the rpsec

    #if remamining items = 0, then coupon applies to all items
    #if remaining_items == 0
    #  discounted_cart["#{item} W/COUPON"] =
    #  {:price => discount_price, :clearance => clearance, :count => coupon_bundles}

    #if remamining items != 0, then apply coupons and return the remaining items
    #without a discount
    #else
      discounted_cart["#{item}"] =
      {:price => price, :clearance => clearance, :count => remaining_items}

      discounted_cart["#{item} W/COUPON"] =
      {:price => discount_price, :clearance => clearance, :count => coupon_bundles}
      #binding.pry
    #end

    #if no coupon, return item
    else
    discounted_cart["#{item}"] =
    {:price => price, :clearance => clearance, :count => count}
    end
    #binding.pry
  end
  #return cart with coupons applied
  discounted_cart
end

def apply_clearance(cart)
  #loop through cart
  cart.each do |item, details|
    #check if item is on clearance
    if details[:clearance] == true
      #discount price by 20% if yes, return item with new price
      details[:price] = (details[:price] * 0.8).round(2)
    end
  end
  #return cart with discounts applied
  cart
end

def checkout(cart, coupons)
  final_price = 0
  #binding.pry
  final_cart = apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  #binding.pry
  final_cart.each do |item, details|
    #binding.pry
    if details[:count] > 0
      final_price += details[:price] * details[:count]
     # binding.pry
    end
  end
  #binding.pry
  if final_price > 100
    final_price = (final_price * 0.9).round(2)
  end
  final_price
end
