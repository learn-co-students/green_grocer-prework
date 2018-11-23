require 'pry'

def consolidate_cart(cart)
  # code here
  new_cart = {}

  cart.each do |item|
    item.each do |name, stats|
      new_cart[name] ||= stats
      new_cart[name][:count] ||= 0
      new_cart[name][:count] += 1
      # binding.pry
    end
  end
  # binding.pry
  new_cart
end

def apply_coupons(cart, coupons)
  # code here
  return cart if coupons.empty?
  new_cart = {}

  cart.each do |name, stats|
    coupons.each do |coupon|
      if name == coupon[:item] && stats[:count] >= coupon[:num]
        coupon_count = stats[:count]/coupon[:num]
        # binding.pry if coupon_count > 1

        new_cart[name] = stats
        new_cart[name][:count] -= (coupon[:num] * coupon_count)

        new_cart["#{name} W/COUPON"] = {
          price: coupon[:cost],
          clearance: stats[:clearance],
          count: coupon_count
        }
        # binding.pry
        # binding.pry if coupon_count > 1
      else
        new_cart[name] = stats
        # binding.pry
      end
    end
  end
  # binding.pry
  new_cart
end

def apply_clearance(cart)
  # code here
  cart.each do |name, stats|
    stats[:price] -= (stats[:price] * 0.2) if stats[:clearance]
  end
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  total = 0
  cart.each do |name, stats|
    total += (stats[:price] * stats[:count])
  end

  total -= (total * 0.1) if total > 100
  total
end
