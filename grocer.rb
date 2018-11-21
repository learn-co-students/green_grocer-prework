require 'pry'
def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |element|
    element.each do |name, parameters|
        cart_hash[name] = parameters
        cart_hash[name][:count] ||= 1
          element.each do |count_name, count_parameters|
            counter ||= 0
            binding.pry
            if cart_hash.keys[counter] == count_name
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
