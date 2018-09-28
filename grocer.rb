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
  binding.pry
 cart["#{name} W/COUPON"] = {:price => coupon[:cost], :clearance => cart[name][:clearance], :count => 1}
  end
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
