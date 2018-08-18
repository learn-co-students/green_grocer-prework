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
    if cart.has_key?(coupon[:item])
      coupon_cart["#{coupon[:item]} W/COUPON"] = {}
      coupon_cart["#{coupon[:item]} W/COUPON"][:price] = coupon[:cost]
      coupon_cart["#{coupon[:item]} W/COUPON"][:clearance] = cart[coupon[:item]][:clearance]
      coupon_cart["#{coupon[:item]} W/COUPON"][:count] = 0
      
      until coupon[:num] == 0 
        # binding.pry
        coupon_cart["#{coupon[:item]} W/COUPON"][:count] += 1
        coupon[:num] -= 1
      end 
     
      
    end 
  end 
  # binding.pry
  coupon_cart 
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
