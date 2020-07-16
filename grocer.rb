require 'pry' 

def consolidate_cart(cart)
  # code here
  consolidated = cart.uniq
  new_cart = {}
  consolidated.each_with_index do |item, index|
    new_cart[item.keys[0]] = item.values[0]
    counter = 0
    cart.each do |object|
      if item == object
        counter += 1
      end 
    end 
    new_cart[item.keys[0]][:count] = counter
  end 
    new_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupon_cart = cart
  coupons.each do |coupon|
   item = coupon[:item]
    if cart.has_key?(item)
      if !cart.has_key?("#{item} W/COUPON")
      coupon_cart["#{item} W/COUPON"] = {}
      coupon_cart["#{item} W/COUPON"][:price] = coupon[:cost]
      coupon_cart["#{item} W/COUPON"][:clearance] = cart[item][:clearance]
      coupon_cart["#{item} W/COUPON"][:count] = 0
      end 
      if cart[item][:count] >= coupon[:num] 
        coupon_cart["#{item} W/COUPON"][:count] += 1
        cart[item][:count] -= coupon[:num]
      end 
    end 
  end 
  coupon_cart 
end

def apply_clearance(cart)
  # code here
  cart.each do |item, value|
    if value[:clearance] == true 
      value[:price] = (value[:price]*0.8).round(1)
    end 
  end 
  cart
end

def checkout(cart, coupons)
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)

  
  cart = apply_clearance(cart)
  total = 0 
  cart.each do |item, value|
    total+= value[:price]*value[:count] # * value[:price]
  end 
  if total > 100 
    total = (total * 0.9).round(1)
  end 
  total
  # code here

end