require 'pry'
def consolidate_cart(cart)
  counter = 0
  cart_hash = {}
  cart.each do |element|
    element.each do |name, parameters|
        cart_hash[name] = parameters
        cart_hash[name][:count] ||= 0
          element.each do |count_name, count_parameters|
            if name == count_name
              cart_hash[name][:count] += 1
            end
            counter += 1
          end
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  
end

def apply_clearance(cart)
  
end

def checkout(cart, coupons)
  
end
