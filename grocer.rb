require "pry"

# [
#   {"AVOCADO" => {:price => 3.0, :clearance => true }},
#   {"AVOCADO" => {:price => 3.0, :clearance => true }},
#   {"KALE"    => {:price => 3.0, :clearance => false}}
# ]

def consolidate_cart(cart)
  result = {}
  cart.each do |item|
    item.each do |key, object_value|
      if result[key] == nil
        result[key] = object_value
        result[key][:count] = 1
      else
        result[key][:count] += 1
      end
    end
  end
  result
end

def apply_coupons(cart_before_coupons, coupons)
  cart_after_coupons = {}
  cart_before_coupons.each do |grocery_item_name, grocery_attributes|
    cart_after_coupons[grocery_item_name] = cart_before_coupons[grocery_item_name]
    coupons.each do |coupon|
      if grocery_item_name == coupon[:item]
        coupon_number = coupon[:num]
        if grocery_attributes[:count] >= coupon[:num]
          items_after_coupon = grocery_attributes[:count] - coupon_number
          grocery_attributes[:count] = items_after_coupon
        else
          next
        end
        if cart_after_coupons["#{grocery_item_name} W/COUPON"]
          cart_after_coupons["#{grocery_item_name} W/COUPON"][:count] += 1
        else
          cart_after_coupons["#{grocery_item_name} W/COUPON"] = {:price => coupon[:cost], :clearance => grocery_attributes[:clearance], :count => 1}
        end
      end
    end
  end
  cart_after_coupons
end

def apply_clearance(cart)
  cart.each do |item, attributes|
    if attributes[:clearance]
      attributes[:price] = (attributes[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  total_cost = 0
  consolidated_cart = consolidate_cart(cart)
  consolidated_cart_with_coupons = apply_coupons(consolidated_cart, coupons)
  apply_clearance(consolidated_cart_with_coupons)
  consolidated_cart_with_coupons.each do |grocery_item_name, grocery_attribute|
    total_cost += grocery_attribute[:price] * grocery_attribute[:count]
  end
  if total_cost > 100
    total_cost *= 0.9
  end
  total_cost
end
