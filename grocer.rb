require 'pry'

def consolidate_cart(cart)
  count = Hash.new(0)
  new_cart = {}
  cart.each do |item|
    count[item.keys[0]] += 1
  end 
  cart.each do |item|
    new_cart[item.keys[0]] = item.values[0]
    new_cart[item.keys[0]][:count] = count[item.keys[0]]
  end 
  new_cart 
end

def apply_coupons(cart, coupons)
  counter_hash= Hash.new(0)
  temp_cart = {} 
  coupons.each do |coupon|
    cart.each do |item, info|
      if coupon[:item] == item 
        counter_hash[item] += 1
        if coupon[:num] == info[:count]
          temp_cart["#{item} W/COUPON"] = info.dup 
          temp_cart["#{item} W/COUPON"][:price] = coupon[:cost]
          temp_cart["#{item} W/COUPON"][:count] = counter_hash[item]
          cart[item][:count] = 0 
        elsif coupon[:num] < info[:count] 
          remainder = cart[item][:count] - coupon[:num] 
          temp_cart["#{item} W/COUPON"] = info.dup 
          temp_cart["#{item} W/COUPON"][:count] = counter_hash[item]
          temp_cart["#{item} W/COUPON"][:price] = coupon[:cost]
          if remainder > 0 
            cart[item][:count] = remainder 
          end 
        end 
      end 
    end 
  end 
  temp_cart.each do |k,v|
    cart[k] = v 
  end 
  cart
end

def apply_clearance(cart)
  cart.each do |item, info|
    if info[:clearance]
      info[:price] *= 0.8
      info[:price] = info[:price].round(2)
    end 
  end 
  cart 
end

def total_price(cart)
  total = 0 
  cart.each do |item, info|
    total += (info[:price] * info[:count])
  end 
  total 
end 

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)
  total = total_price(new_cart)
  if total > 100 
    total *= 0.9 
    total= total.round(2)
  end
  total 
end
