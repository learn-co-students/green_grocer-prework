require 'pry'

def consolidate_cart(cart)
  output_hash = {}
  
  cart.each do |el|
    el.each do |name, values|
      if !output_hash[name]
        output_hash[name] = values
        output_hash[name].merge!(count: 1)
      else
        output_hash[name][:count] += 1
      end
    end
  end
  output_hash
end

def apply_coupons(cart, coupons)
  puts "====================test================================"
#   output_hash = cart
  
#   coupons.each do |coupon| 
#     puts coupon
#     cart.each do |cart_item, details|
      
#       if coupon[:item] == cart_item
#         coupon_count = coupon[:num] > details[:count] ? details[:count] : coupon[:num]
#         output_hash["#{cart_item} W/COUPON"] = {
#           price: coupon[:cost],
#           clearance: true,
#           count: coupon_count
#         }
#         output_hash[cart_item][:count] -= coupon_count
#       end
#     end
#   end
  
#   output_hash
end

def apply_coupons(cart, coupons)
  
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
