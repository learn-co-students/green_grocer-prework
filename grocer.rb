require 'pry'

def consolidate_cart(cart)
  hash = {}
  count_array = []
  cart.each do |hashes|
    count_array << hashes.keys.join
    hashes.each do |key, value|
      hash[key] = value
      hash[key][:count] = count_array.count(key)
    end
  end
  hash
end

def apply_coupons(cart, coupons)
  hash = {}
  hash.merge!(cart)
  coupons.each do |coupon|
    cart.each do |item|
      if coupon.values.include?(item[0])
        if item[1][:count] >= coupon[:num]
          times = item[1][:count] / coupon[:num]
          item[1][:count] = item[1][:count] % coupon[:num]
          hash[item[0] + " W/COUPON"] = { :price => coupon[:cost], :clearance => item[1][:clearance], :count => times }
        end
      end
    end
  end
  hash
end

def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance] == true
      info[:price] = (info[:price] * 0.8).round(1)
    end
  end
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  cart_total = 0
  cart.each do |item ,info|
    cart_total += info[:price] * info[:count]
  end
  if cart_total > 100
    cart_total = cart_total * 0.9
  end
  cart_total
end
