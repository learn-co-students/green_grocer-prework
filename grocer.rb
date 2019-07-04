  require 'pry'
def consolidate_cart(cart)
  cart.each_with_object({}) do |key, value|
    key.each do |k, v|
      if value[k]
        v[:count] += 1
      else
        v[:count] = 1
        value[k] = v
      end
    end
  end
end

def apply_coupons(cart, coupons)
  new_hash = {}
  cart.each do |food, value|
    coupons.each do |coupon|
      if food == coupon[:item] && cart[food][:count] >= coupon[:num]
        cart[food][:count] = cart[food][:count] - coupon[:num]
        if new_hash["#{food} W/COUPON"]
        new_hash["#{food} W/COUPON"][:count] += 1
      else
        new_hash["#{food} W/COUPON"] = {
          :price => coupon[:cost],
          :clearance => value[:clearance],
          :count => 1
        }
        end
      end
    end
    new_hash[food] = value
  end
  new_hash
end

def apply_clearance(cart)
  new_hash = {}
  cart.each do |food, info|
    if info[:clearance]
      new_price = info[:price] -= info[:price] * 0.2
      new_hash[food] = info
    else
      new_hash[food] = info
    end
  end
  new_hash
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0

  cart.each do |name, properties|
    total += properties[:price] * properties[:count]
  end
  if total > 100
  discount = total * 0.1
  total = total - discount
  end
  total
end
