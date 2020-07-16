require 'pry'
def consolidate_cart(cart)
  total_cart = {}

  cart.each do |item|
    item.each do |name, info|
      if total_cart.keys.include?(name) == false
        total_cart[name] = info.merge!(:count => 1)
      else
        total_cart[name][:count] +=1
      end
    end
  end
  total_cart
end

def apply_coupons(cart, coupons)
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
  cart.each do |item, info|
    if info[:clearance]
      info[:price] = (info[:price] * 0.8).round(1)
      end
    end
    cart
  end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each do |name, prop|
    total += prop[:price] * prop[:count]
  end
total = total * 0.9 if total > 100
total
end
