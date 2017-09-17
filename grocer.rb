require "pry"

def consolidate_cart(cart)
  # code here
  my_hash = Hash.new
  cart.each do |item|
    if my_hash.keys.include?(item.keys[0]) == false
      my_hash[item.keys[0]] = item.values[0].dup
      my_hash[item.keys[0]][:count] = 1
    elsif my_hash.keys.include?(item.keys[0]) == true
      my_hash[item.keys[0]][:count] += 1
    end
  end
  my_hash
end

def apply_coupons(cart, coupons)
  # code here
  my_cart = cart.dup
  cart.each do |item, info|
    coupons.each do |coupon|
      if item == coupon[:item] && my_cart[item][:count] >= coupon[:num]
        my_cart[item][:count] -= coupon[:num]
        if my_cart.keys.include?("#{item} W/COUPON") == false
          my_cart["#{item} W/COUPON"] = {:price => coupon[:cost], :clearance => my_cart[item][:clearance], :count => 1}
        else
          my_cart["#{item} W/COUPON"][:count] += 1
        end
      end
    end
  end
  my_cart
end

def apply_clearance(cart)
  # code here
  my_cart = cart.dup
  my_cart.each do |item, info|
    if info[:clearance] == true
      info[:price] *= 0.8
      info[:price] = info[:price].round(2)
    end
  end
  my_cart
end

def checkout(cart, coupons)
  # code here
  my_cart = cart.dup
  my_cart = consolidate_cart(my_cart)
  my_cart = apply_coupons(my_cart, coupons)
  my_cart = apply_clearance(my_cart)
  total = 0.0
  my_cart.each do |item, info|
    total += info[:price] * info[:count].to_f
  end
  total *= 0.9 if total > 100.0
  total.round(2)
end
