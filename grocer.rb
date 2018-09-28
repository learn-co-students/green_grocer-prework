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
   //is the count required fot the coupon greter or equal to the number of //items in the cart. this is an if statement or dont run code
   
    name = coupon[:item]
  #binding.pry
    if cart["#{name} W/COUPON"] 
        cart["#{name} W/COUPON"][:count] += 1

    else
        cart["#{name} W/COUPON"] = {:price => coupon[:cost], :clearance => cart[name][:clearance], :count => 1}
        
        
   //if adjusted the cart, subtract the cpunt from the cart by appropiate number 
binding.pry
  end
  end
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
