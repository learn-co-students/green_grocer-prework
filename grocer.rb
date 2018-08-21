require "pry"
# each_with_object

def consolidate_cart(cart)
  cart_hash = {}
  cart.each do |food_item_hash|
    food_item_frequency = cart.count(food_item_hash)
    food_item_hash.each do |food_item_key, attribute_hash|
      attribute_hash[:count] = food_item_frequency
        if cart_hash == {}
          cart_hash = {food_item_key => attribute_hash}
        else  
          cart_hash[food_item_key] = attribute_hash
        end
    end 
  end 
  cart_hash
end


def apply_coupons(cart, coupons)
# cart is a {} 
# coupons is an [] containing one {} or multiple {}es.
#  final_hash = nil
#  counter = 0 
  coupons.each do |coupon_hash|
# binding.pry 
    name = coupon_hash[:item]
    if cart[name] && cart[name][:count] >= coupon_hash[:num]
      if cart["#{name} W/COUPON"] 
        cart["#{name} W/COUPON"][:count] += 1
      else 
        cart["#{name} W/COUPON"] = {:price => coupon_hash[:cost], :clearance => cart[name][:clearance], :count => 1}
      end 
  #  if cart.keys.include?(coupon_hash[:item])  # && coupon_hash[:item][:num] <=  cart[coupon_hash[:item]][:count]
  #    binding.pry
   #   counter += 1
      cart[name][:count] -= coupon_hash[:num]
   #   cart[coupon_hash[:item] + " W/COUPON"] = {:price => coupon_hash[:cost], :clearance => cart[coupon_hash[:item]][:clearance], :count => 1}
    end
  end 
  cart 
end











def apply_clearance(cart)
  
end


def checkout(cart, coupons)
  
end