require 'pry'

def consolidate_cart(cart)
  consolidated_items = {}
  cart.each do |item_info|
    item_info.each do |item, info|
      if consolidated_items.keys.include?(item)
        consolidated_items[item][:count] += 1
      else
        consolidated_items[item] = info
        consolidated_items[item][:count] = 1
      end
    end
  end
  consolidated_items
end

def apply_coupons(cart, coupons)
    coupons.each do |info|

      coupon_item = info[:item]
      if cart.key?(info[:item]) && !cart.key?("#{coupon_item} W/COUPON") && cart[coupon_item][:count] >= info[:num]
        cart["#{coupon_item} W/COUPON"] = {}
        cart["#{coupon_item} W/COUPON"][:price] = info[:cost]
        cart["#{coupon_item} W/COUPON"][:clearance] = cart[coupon_item][:clearance]
        cart["#{coupon_item} W/COUPON"][:count] = 1
        cart[coupon_item][:count] = (cart[coupon_item][:count]) - (info[:num])
      elsif cart.key?(info[:item]) && cart.key?("#{coupon_item} W/COUPON") && cart[coupon_item][:count] >= info[:num]
        cart["#{coupon_item} W/COUPON"][:count] += 1
        cart[coupon_item][:count] = (cart[coupon_item][:count]) - (info[:num])
      end
    end
  cart
end

def apply_clearance(cart)
  discounted = {}
  cart.map do |item, info|
    if info[:clearance] == true
      info[:price] = ((info[:price]) * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  consolidated = consolidate_cart(cart)
  cart_w_coupons = apply_coupons(consolidated, coupons)
  discounted_cart = apply_clearance(cart_w_coupons)
  total = 0.0
  discounted_cart.each do |name, info|
    total += (info[:price] * info[:count])
  end
  if total >= 100
     total = total * 0.90
     total
  else
    total
  end
end
