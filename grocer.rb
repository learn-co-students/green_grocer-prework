require 'pry'

def consolidate_cart(cart)
  # code here
  new_hash = {}
  cart.each do |groceries|
    groceries.each do |item, item_data|
      if new_hash[item] == nil
        new_hash[item] = {}
        new_hash[item] = item_data
        new_hash[item][:count] = 1
      else
        new_hash[item][:count] += 1
      end
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  # code here
  result = {}
  cart.each do |item, item_data|
    result[item] = item_data
    coupons.each do |coupon|
      if item == coupon[:item] && item_data[:count] >= coupon[:num]
        item_data[:count] -= coupon[:num]
        if result["#{item} W/COUPON"] != nil 
          result["#{item} W/COUPON"][:count] += 1 
        else 
          result["#{item} W/COUPON"] = {
            :price => coupon[:cost],
            :clearance => item_data[:clearance],
            :count => 1
          }
        end
      end
    end
  end
  result
end

def apply_clearance(cart)
  # code here
  cart.each do |item, item_data|
    cart_item = cart[item]
    if cart_item[:clearance] == true
      cart_item[:price] = cart_item[:price] - (cart_item[:price] * 0.2) 
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  total = 0
  consolidated_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(consolidated_cart, coupons)
  applied_clearance = apply_clearance(applied_coupons)
  applied_clearance.each do |k, v|
    total += v[:price] * v[:count]
  end
  if total > 100
    total *= 0.9
  end
  total
end
