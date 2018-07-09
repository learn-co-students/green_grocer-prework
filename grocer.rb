def consolidate_cart(cart)
  # code here
  res = {}
  cart.each{|item|
    if res[item.keys[0]] == nil
      res[item.keys[0]] = item.values[0].clone
      res[item.keys[0]][:count] = 1
    else
      res[item.keys[0]][:count]+=1
    end
  }
  res
end
require "pry"
def apply_coupons(cart, coupons)
  # code here
  #cart = consolidate_cart(cart)
  #puts cart, coupons
  
  coupons.each {|coupon|
    if cart[coupon[:item]] != nil 
      if cart[coupon[:item]][:count] >= coupon[:num]
        #coupon[:num] = cart[coupon[:item]][:count]
      
        cart[coupon[:item]][:count] -= coupon[:num]
        if cart[coupon[:item] + " W/COUPON"] == nil
          cart[coupon[:item] + " W/COUPON"] = {:price => coupon[:cost], :clearance => cart[coupon[:item]][:clearance], :count => 1}
        else
          cart[coupon[:item] + " W/COUPON"][:count] += 1
        end
      end
    end
    #pry
  }
  cart
end

def apply_clearance(cart)
  # code here
  cart.each {|name, item|
    if item[:clearance] === true
      item[:price] = (item[:price]*0.8).round(1)
    end
  }
  cart
end

def checkout(cart, coupons)
  # code here
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart,coupons)
  cart = apply_clearance(cart)
  total = 0
  cart.each{|name, item|
    total += item[:price] * item[:count]
  }
  if total > 100
    total *= 0.9
  end
  total
end
