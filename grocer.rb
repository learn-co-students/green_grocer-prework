require 'pry'

def consolidate_cart(cart)
  new_hash = {}
  
  cart.each do |hash|
    hash.each do |food, details|
      if new_hash.include?(food)
        new_hash[food][:count] += 1
      else
        new_hash[food] = details
        new_hash[food][:count] = 1
      end
    end
  end
  
return new_hash
end

def apply_coupons(cart, coupons)
  
  coupons.each do |coupon|
    item = coupon[:item]
    num = coupon[:num]
    cost = coupon[:cost]
    is_clearance = true
    
    if cart.include?(item) && cart[item][:count] > num/2
      cart[item][:count] -= num
      is_clearance = cart[item][:clearance]
    else
      next
    end
    
    if cart.include?("#{item} W/COUPON")
      cart["#{item} W/COUPON"][:count] += 1
    else
      cart["#{item} W/COUPON"] = {price: cost, clearance: is_clearance, count: 1}
    end
    
  end
  
return cart
end

def apply_clearance(cart)
  new_hash = {}
  
  cart.each do |key, value|
    if value[:clearance] == true
      value[:price] = (value[:price]*0.8).round(2)
    end
    new_hash[key] = value
  end
  
  return new_hash
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  new_hash = apply_clearance(apply_coupons(new_cart, coupons))
  total = 0.0
  
  new_hash.each do |key, value|
    total += (value[:price] * value[:count])
  end
  
  if total > 100
    total = total*0.9
  end
  
  return total
end
