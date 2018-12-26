require 'pry'

def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each do |item|
    item.each do |name, attributes|
      consolidated_cart[name] = attributes
      consolidated_cart[name][:count] = cart.count { |x| x == item }
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  coupons.collect do |item_hash|
    if cart.key?(item_hash[:item]) && cart[item_hash[:item]][:count] >= item_hash[:num]
      if cart["#{item_hash[:item]} W/COUPON"]
        cart["#{item_hash[:item]} W/COUPON"][:count] += 1
      else
        cart["#{item_hash[:item]} W/COUPON"] = {:price => item_hash[:cost],
        :clearance => cart[item_hash[:item]][:clearance], :count => 1}
      end
      cart[item_hash[:item]][:count] = cart[item_hash[:item]][:count] - item_hash[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |_item, attributes|
    if attributes[:clearance] == true
      attributes[:price] = (attributes[:price] * (4.0 / 5.0)).round(2)
    end
  end
end

def checkout(cart, coupons)
  total_price = []
  consolidated = consolidate_cart(cart)
  coupons_applied = apply_coupons(consolidated, coupons)
  clearance_applied = apply_clearance(coupons_applied)
  clearance_applied.each do |_product, attributes|
    total_price << (attributes[:price] * attributes[:count])
  end
  if total_price.sum < 100
    final_price = total_price.sum
  else
    final_price = (total_price.sum * (9.0 / 10.0)).round(2)
  end
  final_price
end
