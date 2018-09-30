require 'pry'
def consolidate_cart(cart)
thanks= {}
  cart.each do |item|
    item.each do |fruit, attributes|
    
     if thanks[fruit]
      attributes[:count] += 1
     else
      attributes[:count] = 1
      thanks[fruit] = attributes
     end
   end
 end
 thanks
    end
  



def apply_coupons(cart, coupons)
  # code here
coupons.each do |coupon|
 name = coupon[:item]   
   
   if if cart[name] && cart[name][:count] >= coupon[:num]
 
    if cart["#{name} W/COUPON"] 
        cart["#{name} W/COUPON"][:count] += 1

    else
        cart["#{name} W/COUPON"] = {:price => coupon[:cost], :count => 1}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
  end
      cart[name][:count] -= coupon[:num]
end
end
end       
cart
end


def apply_clearance(cart)
  # code here
  cart.each do |fruit, attributes|
    #binding.pry
    if cart[fruit][:clearance] == true
     clearance = cart[fruit][:price] *= 0.8 
     clearance.round(2)
     binding.pry
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
end
