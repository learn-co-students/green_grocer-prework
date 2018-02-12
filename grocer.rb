require 'pry'

def consolidate_cart(cart)
  cart_hash = {}
  cart.each { |hash|
    item = hash.keys[0]
      unless cart_hash.include?(item)
        cart_hash[item] = hash.values[0]
        cart_hash[item][:count] = 1
      else
        cart_hash[item][:count] += 1

      end
    }
  cart_hash
end


def apply_coupons(cart, coupons)
  coupons.each { |coupon|
    if cart.include?(coupon[:item])
      item = coupon[:item]
      count = cart[item][:count]
      if coupon[:num] <= count
        cart[("#{item} W/COUPON")] =
        {:price => coupon[:cost], :clearance => cart[item][:clearance], :count => (cart[item][:count] / coupon[:num])}
        cart[item][:count] = cart[item][:count] % coupon[:num]
      end
    end
  }
  cart
end


def apply_clearance(cart)
  if cart.is_a?(Array)
    cart = consolidate_cart(cart)
  else
    cart = cart
  end
  cart.each { |foods, info|
    if cart[foods][:clearance] == true
      cart[foods][:price] = (cart[foods][:price] - (cart[foods][:price] * 0.2))
    end
  }
  cart
end

def checkout(cart, coupons)
  total = 0.0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart,coupons)
  cart = apply_clearance(cart)
  cart.each { |foods, info|
    total += info[:price] * info[:count]
    if total > 100
      total = (total - (total * 0.1))
    end
  }
  total
end
