require 'pry'
def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |element|
    element.each do |item, parameters|
        cart_hash[item] = parameters
        cart_hash[item][:count] ||= 0
          element.each do |count_item, count_parameters|
            if item == count_item
              cart_hash[item][:count] += 1
            end
          end
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  cart_hash = {}
  cart.each do |item, parameters|
    parameters.each do |parameter, value|
      cart_hash[item] = parameters
      coupons.each do |element|
        element.each do |coupon_parameter, coupon_value|
          if element[:item] == item
            cart_hash["#{item} W/COUPON"] = parameters
            binding.pry
            cart_hash["#{item} W/COUPON"][:price] = element[:cost]
            cart_hash["#{item} W/COUPON"][:count] = 1
            cart_hash[item][:count] -= element[:num]
          end
        end
      end 
    end 
  end
  #binding.pry
  cart_hash
end

def apply_clearance(cart)
  
end

def checkout(cart, coupons)
  
end
