require 'pry'

def consolidate_cart(cart)
  return_hash = {}
  cart.each do |item|
    item.each do |key, val|
      if return_hash.keys.include?(key)
        return_hash[key][:count] += 1
      else
        return_hash[key] = val
        return_hash[key][:count] = 1
      end
    end
  end
  return_hash
end

# COMBAK: 
def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = { count: 1, price: coupon[:cost] }
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]

      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end


def apply_clearance(cart)
  cart.each do |item, details|
    if cart[item][:clearance]
      cart[item][:price] = (details[:price] * 0.80).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  clean_cart = consolidate_cart(cart)
  coupon_clipper = apply_coupons(clean_cart, coupons)
  sale = apply_clearance(coupon_clipper)

  total = 0

  sale.each do |name, object|
    total += object[:price] * object[:count]
  end

  if total > 100
    total = total * 0.90
  end

  total

end
