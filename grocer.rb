require "pry"

def consolidate_cart(cart)
  # code here
  consolidated = {}
  cart.each do |item|
    item.each do |key, value|
      if consolidated.keys.include?(key) == false
        consolidated[key] = value.merge!(:count => 1)
      else
        consolidated[key][:count] += 1
      end
    end
  end
  consolidated
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    cart.keys.each do |item|
      if coupon[:item] == item && cart[item][:count] >= coupon[:num]
        cart["#{item} W/COUPON"] = {
          price: coupon[:cost],
          clearance: cart[item][:clearance],
          count: cart[item][:count] / coupon[:num]
        }
        cart[item][:count] -= (cart[item][:count] / coupon[:num]) * coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, details|
    if details[:clearance].class == (TrueClass || FalseClass) && details[:clearance]
      details[:price] -= (details[:price] * 0.2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  discounted_cart = []
  total = 0
  #consolidate_cart(cart)
  #apply_coupons(consolidate_cart(cart), coupons)
  discounted_cart << apply_clearance(apply_coupons(consolidate_cart(cart), coupons))
  discounted_cart.each do |item|
    item.each do |name, details|
      total += (details[:price] * details[:count])
    end
  end
  if total > 100
    total -= (total * 0.1)
  end
  total
end
