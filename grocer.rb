require "pry"

def consolidate_cart(cart)
  new_hash = {}
  cart.each do |x|
    x.each do |food, info|
      if new_hash.keys.include?(food)
        new_hash[food][:count] += 1
        # binding.pry
      else
        new_hash[food] = info
        new_hash[food][:count] = 1
      end
    end
  end
  new_hash
end

def apply_coupons(cart, coupons)
  cart.clone.each do |food, info|
    coupons.each do |x|
      if food == x[:item] && cart[food][:count] >= x[:num]
        cart["#{food} W/COUPON"] = {
          :price => x[:cost],
          :clearance => cart[food][:clearance],
          :count => cart[food][:count] / x[:num]
        }
        cart[food][:count] = cart[food][:count] % x[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |food, info|
    cart[food][:price] = (cart[food][:price] * 0.8).round(2) if cart[food][:clearance]
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
    cart.each do |food, info|
      total += cart[food][:price] * cart[food][:count]
    end
    if total > 100.00
      total -= (total * 0.1)
      total
    else
      total
    end
  end
