require "pry"

def consolidate_cart(cart)
  cart_consolidated = {}
  items_in_cart = []
  cart.each do |item|
    item.each do |item_name, item_details|
      items_in_cart << item_name
      cart_consolidated[item_name] = item_details
    end
  end
  cart_consolidated.each do |item_name, item_details|
    item_details[:count] = items_in_cart.count(item_name)
  end
  cart_consolidated
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    cart.clone.each do |item_name, item_details|
      if coupon[:item] == item_name && coupon[:num] <= item_details[:count]
        if cart.keys.include?("#{item_name} W/COUPON")
          cart["#{item_name} W/COUPON"][:count] += 1
          item_details[:count] = item_details[:count] - coupon[:num]
        else
          item_details[:count] = item_details[:count] - coupon[:num]
          item_price = coupon[:cost]
          item_clearance = item_details[:clearance]
          cart["#{item_name} W/COUPON"] = {price: item_price, clearance: item_clearance, count: 1}
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, details|
    if details[:clearance] == true
      details[:price] = (details[:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cart_total = 0
  cart.each_value do |item_details|
    cart_total += (item_details[:price] * item_details[:count])
  end
  if cart_total > 100
    cart_total = (cart_total * 0.9).round(2)
  end
  cart_total
end
