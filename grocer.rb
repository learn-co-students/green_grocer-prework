require "pry"

def consolidate_cart(cart)
  hash = {}
  cart.each do |item|
    item.each do |key, value|
      if hash[key]
        hash[key][:count] += 1
      else
        hash[key] = value
        hash[key][:count] = 1
      end
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  hash = {}
  cart.each do |key, value|
    hash[key] = value
    coupons.each do |coupon|
      if coupon[:item] == key
        cart_num = cart[key][:count]
        coupon_num = coupon[:num]
        hash[key][:count] = cart_num % coupon_num
        if hash["#{key} W/COUPON"]
          hash["#{key} W/COUPON"][:count] += (cart_num / coupon_num).floor
        else
          hash["#{key} W/COUPON"] = {}
          hash["#{key} W/COUPON"][:price] = coupon[:cost]
          hash["#{key} W/COUPON"][:clearance] = cart[key][:clearance]
          hash["#{key} W/COUPON"][:count] = (cart_num / coupon_num).floor
        end
      end
    end
  end
  hash
end

def apply_clearance(cart)
  hash = {}
  cart.each do |key, value|
    hash[key] = value
    if value[:clearance] == true
      new_price = value[:price] * 0.8
      hash[key][:price] = new_price.round(2)
    end
  end
  hash
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  total = 0
  clearance_cart.each do |key, value|
    total += value[:price] * value[:count]
  end
  if total > 100
    total * 0.9
  else
    total
  end
end
