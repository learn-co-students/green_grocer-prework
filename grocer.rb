require 'pry'

def consolidate_cart(cart)
  new_cart = {}
  cart.each do | item_hash |
    if !new_cart[item_hash.keys[0]]
      new_cart[item_hash.keys[0]] = item_hash.values[0]
      new_cart[item_hash.keys[0]][:count] = 1
    else
      new_cart[item_hash.keys[0]][:count] += 1
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  new_cart = cart
  coupons.each do | coupon |
    name = coupon[:item]
    if new_cart[name]
      if coupon[:num] <= new_cart[name][:count] # || coupon[:cost] / coupon[:num] > new_cart[name][:price]
        new_cart[name + " W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => cart[name][:clearance],
          :count => new_cart[name][:count] / coupon[:num]
        }
        new_cart[name][:count] %= coupon[:num]
        new_cart[name][:clearance] = false
      end
    end
  end
  new_cart
end

def apply_clearance(cart)
  new_cart = cart
  cart.each do | item, item_data |
    if item_data[:clearance] == true
      new_cart[item][:price] = (new_cart[item][:price] * 0.8).round(1)
    end
  end
end

def checkout(cart, coupons)
  total = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cart.each do | item , item_data |
    total += item_data[:count] * item_data[:price]
  end
  if total > 100
    total *= 0.9
  end
  total
end
