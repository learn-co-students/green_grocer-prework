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
  coupons.each do |coupon_hash|
    
    if cart.keys.include?(coupon_hash[:item]) 
      cart[coupon_hash[:item] + " W/COUPON"] = {:price => coupon_hash[:cost], :clearance => cart[coupon_hash[:item]][:clearance], :count => 1}
       cart[coupon_hash[:item]] = cart[coupon_hash[:item]][:count] - coupon_hash[:item][:num]
    end 
# binding.pry     
    
  #  coupon_hash.each do |coupon_symbol, food_item_value|
   #   cart.each do |food_item_key, attribute_hash|
# binding.pry 
 #       if food_item_key == food_item_value 
  #        cart[food_item_key" W/COUPON"] = {:price => coupon_hash[:cost], :clearance => attribute_hash[:clearance], :count => 1}
          
# binding.pry
#          cart[food_item_key][:count] = cart[food_item_key][:count] - coupon_hash[:num]
#  binding.pry # Everything checks out here.
#          cart[food_item_key + " W/COUPON"] = {:price => coupon_hash[:cost], :clearance => attribute_hash[:clearance], :count => 1}
# binding.pry # Can't pry here.
#          final_hash = cart# binding.pry
        end 
 #     end
 #   end
#  end
#  final_hash
 binding.pry
end


def apply_clearance(cart)
  
end


def checkout(cart, coupons)
  
end