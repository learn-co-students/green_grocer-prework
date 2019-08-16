require "pry"

def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |items|
    items.each do |name, price_hash|
      if cart_hash.has_key?(name)
        cart_hash[name][:count] += 1
      else
        cart_hash[name] = price_hash
        cart_hash[name][:count] = 1
      end
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  i = 0
  coupons.each do |hash|
    hash.each do |key, value|
      if cart.has_key?("#{value} W/COUPON") && cart[value][:count] >= coupons[i][:num]
        cart[value][:count] -= coupons[i][:num]
        cart["#{value} W/COUPON"][:count] += 1
      elsif cart.has_key?(value) && cart[value][:count] >= coupons[i][:num]
        cart[value][:count] -= coupons[i][:num]
        cart["#{value} W/COUPON"] = {}
        cart["#{value} W/COUPON"][:price] = coupons[i][:cost]
        cart["#{value} W/COUPON"][:clearance] = cart[value][:clearance]
        cart["#{value} W/COUPON"][:count] = 1
      end
    end
    i += 1
  end
  cart
end

def apply_clearance(cart)
  cart.each do |items|
    items.each do |names|
      if cart[names] == nil
        next
      elsif cart[names][:clearance] == true
        cart[names][:price] = (cart[names][:price] * (0.8)).round(2)
      end
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cart.each do |item, specs|
    num = specs[:count]
    while num > 0
      total += specs[:price]
      num -= 1
    end
  end
  if total > 100
    total -= total * 0.1
  end
  total
end
