require "pry"

def consolidate_cart(cart)
  # code here
  hash = {}
  cart.each do |items|
    items.each do |item, info|
      if hash.include?(item)
        hash[item][:count] += 1
      else
        hash[item] = info
        hash[item][:count] = 1
      end
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    item = coupon[:item]
    if cart.include?(item)
      if cart[item][:count] >= coupon[:num] #checking to see if cart meets minimum coupon quantity requirements
        cart[item][:count] -= coupon[:num]
        if cart.include?("#{item} W/COUPON")
          cart["#{item} W/COUPON"][:count] += 1
        else
          cart["#{item} W/COUPON"] = {price: coupon[:cost], clearance: cart[item][:clearance], count: 1}
        end
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
  cart.each do |key, value|
    if value[:clearance]
      value[:price] = (value[:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each do |key, value|
    total += value[:price] * value[:count] #iterating through cart and multiplying discounted price & quantity
  end
  if total > 100
    total *= 0.9
  end
  total
end
