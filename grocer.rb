require 'pry'
def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |element|
    element.each do |item, parameters|
      parameters.each do |parameter, value|
        cart_hash[item] = {}
        cart_hash[item][parameter] ||= value
      end 
    end
  end 
  binding.pry
  cart_hash
end

def apply_coupons(cart, coupons)
  
end

def apply_clearance(cart)
  
end

def checkout(cart, coupons)
  
end
